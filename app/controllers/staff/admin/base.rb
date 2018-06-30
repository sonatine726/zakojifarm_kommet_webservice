class Staff::Admin::Base < ApplicationController
  include SessionControllerModule
  
  layout 'staff/admin'

  skip_before_action :authenticate_user!

  protected
  def virtual_current_member(id)
    current_admin_member(id)
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
  def current_admin_member(id = nil)
    if id
      @current_admin_member ||= AdminMember.find_by(id: id)
    else
      @current_admin_member
    end
  end

  helper_method :current_admin_member
end
