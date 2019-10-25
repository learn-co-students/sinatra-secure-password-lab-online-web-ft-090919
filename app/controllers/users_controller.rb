
class UsersController < ApplicationController

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
  

end
