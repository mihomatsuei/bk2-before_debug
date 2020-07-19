class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  # only: [:show,:edit,:index]を追加
  before_action :authenticate_user!, only: [:show,:edit,:index]

  protected
  def after_sign_in_path_for(resource)
    # root_path→user_path(resource)に変更
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
