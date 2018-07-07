module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from SecurityError do |exception|
      redirect_to root_url, notice: 'Admin画面へのアクセス権限がありません'
    end

    rescue_from ActionController::BadRequest, with: :rescue400
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from ActionController::ParameterMissing, with: :rescue400
  end

  private

  def rescue404(e)
    @exception = e
    render 'errors/not_found_error', status: 404
  end

  def rescue400(e)
    @exception = e
    render 'errors/bad_request_error', status: 400
  end
end