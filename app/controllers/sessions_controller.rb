
class SessionsController < ApplicationController

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

  get "/logout" do
    session.clear
    redirect "/"
  end


end
