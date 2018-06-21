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

  def create
    @staff_member = StaffMember.new(create_params)
    if @staff_member.save
      flash.notice = '職員アカウントを新規登録しました。'
      redirect_to :admin_staff_members
    else
      flash.now.alert = '職員アカウントの新規登録に失敗しました。'
      render action: 'new'
    end
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    @staff_member.assign_attributes(update_params)
    if @staff_member.save
      flash.notice = '職員アカウントを更新しました。'
      redirect_to :admin_staff_members
    else
      flash.now.alert = '職員アカウントの更新に失敗しました。'
      render action: 'edit'
    end
  end

  def destroy
    staff_member = StaffMember.find(params[:id])
    staff_member.destroy!
    flash.notice = '職員アカウントを削除しました。'
    redirect_to :admin_staff_members
  end

  protected
  def create_params
    params.require(:staff_member).permit(:email, 
                                         :password, 
                                         :family_name,
                                         :given_name, 
                                         :family_name_kana, 
                                         :given_name_kana, 
                                         :start_date, 
                                         :end_date, 
                                         :suspended)
  end

  def update_params
    params.require(:staff_member).permit(:email, 
                                         :family_name,
                                         :given_name, 
                                         :family_name_kana, 
                                         :given_name_kana, 
                                         :start_date, 
                                         :end_date, 
                                         :suspended)
  end
end
