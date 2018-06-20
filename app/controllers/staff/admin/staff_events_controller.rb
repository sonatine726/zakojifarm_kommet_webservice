class Staff::Admin::StaffEventsController < Staff::Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else
      @events = StaffEvent.order(occurred_at: :desc)
    end
    @events = @events.page(params[:page])

    if @staff_member
      full_name = @staff_member.family_name + @staff_member.given_name
      @title = "#{full_name}さんのログイン・ログアウト記録"
    else
      @title = "職員のログイン・ログアウト記録"
    end
  end
end
