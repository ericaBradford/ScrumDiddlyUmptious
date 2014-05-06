class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :delete]

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in)  { |u| u.permit(:username, :password, :remember_me, :role) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :role) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :role) }
    end
end
