class ApplicationController < ActionController::Base
	  before_action :configure_permitted_parameters, if: :devise_controller?

	  def after_sign_in_path_for(resource)
	  	user_path(current_user.id)
	  end

	  def after_sign_out_path_for(resource)
      root_path
      end


  protected
  def configure_permitted_parameters
  	added_attrs = [ :email, :user_name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end


