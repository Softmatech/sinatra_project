require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "SoftmaPass#2019"
    use Rack::Flash
  end

  get "/" do
    erb :welcome
  end

  get "/login" do
    if !logged_in?
      puts "not already logged in"
      erb :login
      else
        puts "user already logged in #{@session[:session_id]}"
      end
  end

  post "/login" do
    if Users_account.exists?(email: params[:email])
      puts "yessssssss"
        @user = Users_account.find_by(email: params[:email])
        if @user.authenticate(params[:password])
          @session = session
          @username = params[:email]
          puts "passs OK #{@session}"
        redirect "/profile"
        else
          puts "problem with your pass"
          
        end
      else
        puts "User doesn.t exist"
      end
      redirect "/login"
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
      # flash[:message] = "Account registered successfully"
    redirect "/"
    end
  end

  get "/profile" do
    puts "email ------>>> #{current_user}"
    erb :profile
  end

  def logged_in?
    !!session[:id]
  end

  def current_user
    @username = Users_account.find_by(session[:id])
    puts "current user ---->>> #{@username}"
  end

end

