class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(session_params)
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Welcome back!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "See you soon!"
  end

 private
  def session_params
    params.permit(:userName, :password)
  end

end
