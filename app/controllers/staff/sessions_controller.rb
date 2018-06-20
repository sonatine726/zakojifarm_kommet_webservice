class Staff::SessionsController < Staff::Base
  skip_before_action :check_staff_login, only: [:new, :create]

  include SessionControllerModule

  private
  def hook_create_susupended(target_member)
    target_member.events.create!(type: 'rejected')
  end

  def hook_create_success(target_member)
    target_member.events.create!(type: 'logged_in')
  end

  def hook_destroy(target_member)
    target_member.events.create!(type: 'loggend_out')
  end
end
