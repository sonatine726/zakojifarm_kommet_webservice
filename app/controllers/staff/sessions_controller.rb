class Staff::SessionsController < Staff::Base
  skip_before_action :check_staff_login, only: [:new, :create]

  def new
    @title = 'スタッフ ログイン'
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(create_params)
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end

    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      flash.notice = 'スタッフとしてログインしました。'
      redirect_to :staff_root
    else
      flash.now.alert = 'スタッフアカウントのメールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'スタッフセッションからログアウトしました。'
    redirect_to :staff_root
  end

  private
  def create_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
