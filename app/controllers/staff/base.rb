class Staff::Base < ApplicationController
  include SessionControllerModule
  
  layout 'staff/staff'

  skip_before_action :authenticate_user!
  before_action :check_source_ip_address

  protected
  def virtual_current_member(id)
    current_staff_member(id)
  end

  def root_url
    :staff_root
  end

  def login_url
    :staff_login
  end

  def target_model
    StaffMember
  end

  def session_id
    :staff_member_id
  end

  def last_access_time_id
    :staff_last_access_time
  end

  def session_name
    'スタッフ'
  end

  def login_form
    Staff::LoginForm
  end

  def authenticator
    Staff::Authenticator
  end

  private
  def current_staff_member(id = nil)
    if id
      @current_staff_member ||= StaffMember.find_by(id: id)
    else
      @current_staff_member
    end
  end

  helper_method :current_staff_member

  def check_source_ip_address
    raise IpAddressRejectedError unless AllowedSource.include?('staff', request.ip)
  end 
end