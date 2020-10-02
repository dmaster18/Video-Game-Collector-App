class UsersController < ApplicationController
  get "/users" do
    session.destroy
    erb :"/users/welcome"
  end

  get "/users/signup" do
    if !session[:user_id]
      @signup_errors = User.signup_errors
      erb :"/users/signup"
    else
      redirect "/users/account"
    end
  end

  post "/users/signup" do
    user = User.new(username: params[:username], password: params[:password])
    user.valid_password?
    if user.valid_username? && user.valid_password?
      user.save
      session[:user_id] = user.id
      redirect "/users/account"
    else
      @signup_errors = User.signup_errors
      erb :"/users/signup"
    end
  end

  get "/users/login" do
    if !session[:user_id]
      @login_errors = User.login_errors
      erb :"/users/login"
    else
      redirect "/users/account"
    end
  end

  post "/users/login" do
    user = User.find_by(username: params[:username])
    @login_errors = User.login_errors
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/account"
    elsif user
      @login_errors << "Incorrect password. Please try again."
      erb :"/users/login"
    else
      @login_errors << "No such username exists in our system."
      erb :"/users/login"
    end
  end

  get '/users/account' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :"/users/account"
    else
      redirect "/users"
    end
  end

  get "/users/logout" do
    if session[:user_id]
      session.destroy
      redirect "/users/login"
    else
      redirect "/users"
    end
  end

end
