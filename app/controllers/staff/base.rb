class Staff::Base < ApplicationController
  layout 'staff/staff'

  skip_before_action :authenticate_user!
  before_action :check_staff_login

  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  def check_staff_login
    unless current_staff_member
      redirect_to :staff_login
    end
  end

  helper_method :current_staff_member
end