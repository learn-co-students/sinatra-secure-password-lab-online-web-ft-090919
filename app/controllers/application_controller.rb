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
    if params[:username].empty? || params[:password].empty?
      redirect to '/failure'
    else
      # binding.pry
      user = User.find_or_create_by(username: params[:username])
      if !user.password
        user.password = params[:password]
        user.balance = 0
        user.save
        # binding.pry if user.balance == nil
      end
      redirect to '/login'
    end
  end

  get '/account' do
    @user = current_user
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do

    user = User.find_by(username: params[:username])
    # binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/account'
    else
      redirect '/failure'
    end
  end


  get "/failure" do
    erb :failure
  end


  get '/deposit' do
    if logged_in?
      @user = current_user
      erb :deposit
    else
      redirect '/login'
    end
  end

  post '/deposit' do
    if logged_in?
      @user = current_user
      @user.balance += params[:deposit].to_f
      @user.save
      redirect '/account'
    else
      redirect '/login'
    end
  end

  get '/withdraw' do
    if logged_in?
      @user = current_user
      erb :withdraw
    else
      redirect '/login'
    end
  end


  post '/withdraw' do
    if logged_in?
      @user = current_user
      if @user.balance >= params[:withdraw].to_f
        @user.balance -= params[:withdraw].to_f
        @user.save
      else
        redirect '/withdraw'
      end
      redirect '/account'
    else
      redirect '/login'
    end
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
