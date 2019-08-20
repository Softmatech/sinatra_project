require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "SoftmaPass#2019"
    # use Rack::Flash
  end

  get "/" do
    erb :welcome
  end

  get "/login" do
    erb :login
  end

  
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    Users_account.create(params)
    redirect "/"
end

end
