module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from SecurityError do |exception|
      redirect_to root_url, notice: 'Admin画面へのアクセス権限がありません'
    end

    rescue_from ForbiddenError, with: :rescue403
    rescue_from IpAddressRejectedError, with: :rescue403
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
  def rescue403(e)
    @exception = e
    render 'errors/forbidden_error', status: 403
  end

  def rescue404(e)
    @exception = e
    render 'errors/not_found_error', status: 404
  end
end