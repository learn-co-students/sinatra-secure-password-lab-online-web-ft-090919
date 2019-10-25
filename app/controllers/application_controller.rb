require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    # binding.pry
    if params[:username].empty? || params[:password].empty?
      redirect to '/failure'
    else
      user = User.find_or_create_by(username: params[:username])
      binding.pry
      redirect to '/login'
    end
  end

  get '/account' do
    binding.pry
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    # binding.pry
    if params[:password].empty? || params[:username].empty?
      redirect '/failure'
    else
      user = User.find_by(username: params[:username])
      # binding.pry
      if user && user.password == session[:password]
        session[:user_id] = user.id
        redirect to '/account'
      else
        redirect '/failure'
      end
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
