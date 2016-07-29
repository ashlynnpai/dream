class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, :unless => :devise_controller?

  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
   #devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end

  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end
end


