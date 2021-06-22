class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = 'Welcome! You have signed up successfully.'
    user_path(resource)
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = 'Signed in successfully.'
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = 'Signed out successfully.'
    root_path
  end
end
