class Staff::Admin::StaffMembersController < Staff::Admin::Base
  def index
    @title = '職員管理'
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [:edit, :admin, staff_member]
  end

  def new
    @title = '職員の新規登録'
    @staff_member = StaffMember.new
  end

  def edit
    @title = '職員アカウントの編集'
    @staff_member = StaffMember.find(params[:id])
  end
end
