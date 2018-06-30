class Staff::SessionsController < Staff::Base
  private

  def hook_create_suspended(target_member)
    target_member.events.create!(type: :rejected)
  end

  def hook_create_success(target_member)
    target_member.events.create!(type: :logged_in)
  end

  def hook_destroy(target_member)
    target_member.events.create!(type: :logged_out)
  end
end
