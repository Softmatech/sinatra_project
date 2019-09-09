require './config/environment'
require 'sinatra/base'

class ApplicationController < Sinatra::Base
  set :method_override, true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get "/" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    end
    erb :welcome
  end

  get "/login" do
    if !(Helpers.is_logged_in?(session))
      puts "not already logged in"
      erb :login
      else
        redirect "/profile"        
      end
  end

  post "/login" do
    if UsersAccount.exists?(email: params[:email])
        @user = UsersAccount.find_by(email: params[:email])
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          @session = session
          puts "passs OK #{@session[:user_id]}"
        redirect "/profile"
        else
          puts "problem with your pass"
          flash[:message] = "Authentication Problem (User/Password)"
        end
    else
        puts "User doesn.t exist"
        flash[:message] = "This email doesn't exist"
    end
  end

  
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if UsersAccount.exists?(email: params[:email])
      flash[:message] = "Sorry, this email is already registered on our database"
      erb :signup
    else
      @users = UsersAccount.create(email: params[:email],password: params[:password])
      flash[:message] = "Account registered successfully"
    redirect "/"
    end
  end

  get "/profile" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      if params[:id]
        @lottery = Lottery.find(params[:id])
        erb :profile
      else
        @lottery = @user.lotteries.first
        erb :profile
      end
    
    end
  end

  get "/profile/:id" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
        @lottery = Lottery.find(params[:id])
        erb :profile
    end
  end

  post "/profile" do
    @user = Helpers.current_user session
    @user.lotteries.create(params)
        @lottery = Lottery.create(params)
        flash[:message] = "Lottery registered successfully"
        redirect "/profile"
  end

  post "/edit/profile/:id" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
        @lottery = Lottery.find(params[:id])
        @lottery.update(params)
        erb :profile
    end
  end

  delete '/delete/profile/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
        @lottery = Lottery.find(params[:id])
        @lottery.delete
        redirect "/profile"
    end
  end

  get '/pos' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      if params[:id]
        @lottery = Lottery.find(params[:id])
      end
    erb :pos
    end
  end
  
  post '/pos' do 
      Post.create(params)
      redirect '/pos'
  end

end