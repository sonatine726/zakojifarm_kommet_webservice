class Staff::AccountsController < Staff::Base
  def show
    @title = 'アカウント情報'
    @staff_member = current_staff_member
  end

  def edit
    @title = 'アカウント情報編集'
    @staff_member = current_staff_member
  end
end
