class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ErrorHandlers if Rails.env.production?
  rescue_from ForbiddenError, with: :rescue403
  rescue_from IpAddressRejectedError, with: :rescue403

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me,:avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end

  private

  def rescue403(e)
    @exception = e
    render 'errors/forbidden_error', status: 403
  end

  def reject_non_xhr
    raise ActionController::BadRequest unless request.xhr?
  end
end
