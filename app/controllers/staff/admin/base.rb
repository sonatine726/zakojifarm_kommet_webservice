class Staff::Admin::Base < ApplicationController
  layout 'staff/admin'

  skip_before_action :authenticate_user!
  before_action :check_admin_login
  
  include SessionValidityModule

  protected
  def current_member
    current_admin_member
  end

  def root_url
    :admin_root
  end

  def login_url
    :admin_login
  end

  def target_model
    AdminMember
  end

  def session_id
    :admin_member_id
  end

  def last_access_time_id
    :admin_last_access_time
  end

  def session_name
    '管理者'
  end

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
