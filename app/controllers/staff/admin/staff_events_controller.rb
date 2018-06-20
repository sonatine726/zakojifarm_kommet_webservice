class Staff::Admin::StaffEventsController < Staff::Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events
    else
      @events = StaffEvent
    end
    @events = @events.order(occurred_at: :desc).includes(:member).page(params[:page])

    if @staff_member
      full_name = @staff_member.family_name + @staff_member.given_name
      @title = "#{full_name}さんのログイン・ログアウト記録"
    else
      @title = "職員のログイン・ログアウト記録"
    end
  end
end
