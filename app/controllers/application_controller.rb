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
    erb :welcome
  end

  get "/login" do
    if !(Helpers.is_logged_in?(session))
      puts "not already logged in"
      erb :login
      else
        # puts "user already logged in #{session[:session_id]}"
        redirect "/profile"        
      end
  end

  post "/login" do
    if Users_account.exists?(email: params[:email])
        @user = Users_account.find_by(email: params[:email])
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
      # redirect "/login"
  end

  
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if Users_account.exists?(email: params[:email])
      flash[:message] = "Sorry, this email is already registered on our database"
      erb :signup
    else
      @users = Users_account.create(email: params[:email],password: params[:password])
      flash[:message] = "Account registered successfully"
    redirect "/"
    end
  end

  get "/profile" do
    if Helpers.is_logged_in?(session)
      puts "Session OK #{session[:user_id]}"
      @user = Helpers.current_user(session)
      puts "User ---->>> #{@user}"
    erb :profile
    end
  end

end