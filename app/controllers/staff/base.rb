class Staff::Base < ApplicationController
  layout 'staff/staff'

  skip_before_action :authenticate_user!
  before_action :check_staff_login

  include SessionValidityModule

  protected
  def current_member
    current_staff_member
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

  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  def check_staff_login
    unless current_staff_member
      flash.alert = 'スタッフとしてログインしてください。'
      redirect_to :staff_login
    end
  end

  helper_method :current_staff_member
end