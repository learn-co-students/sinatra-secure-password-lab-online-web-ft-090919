
class AccountsController < ApplicationController

  get '/account' do
    @user = current_user
    erb :'accounts/account'
  end


  get '/deposit' do
    if logged_in?
      @user = current_user
      erb :'accounts/deposit'
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
      erb :'accounts/withdraw'
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



end
