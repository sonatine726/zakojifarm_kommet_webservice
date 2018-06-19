class Staff::Admin::Base < ApplicationController
  layout 'staff/admin'

  skip_before_action :authenticate_user!
  before_action :check_admin_login

  private
  def current_admin_member
    if session[:admin_member_id]
      @current_admin_member ||= AdminMember.find_by(id: session[:admin_member_id])
    end
  end

  def check_admin_login
    unless current_admin_member
      flash.alert = '管理者としてログインしてください。'
      redirect_to :admin_login
    end
  end

  helper_method :current_admin_member
end
