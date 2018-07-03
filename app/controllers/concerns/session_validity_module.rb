module SessionValidityModule
  extend ActiveSupport::Concern

  included do
    before_action :check_account
    before_action :check_timeout
  end

  private
  TIMEOUT = 60.minutes

  def check_account
    if current_member && !current_member.active?
      session.delete(session_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to login_url
    end
  end

  def check_timeout
    if current_member && session[last_access_time_id]
      if session[last_access_time_id] < TIMEOUT.ago
        session.delete(session_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to login_url and return
      end
    end
    session[last_access_time_id] = Time.current
  end
end