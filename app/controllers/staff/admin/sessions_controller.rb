class Staff::Admin::SessionsController < Staff::Admin::Base
  skip_before_action :check_admin_login, only: [:new, :create]

  def new
    @title = '管理者 ログイン'
    if current_admin_member
      redirect_to :admin_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(create_params)
    if @form.email.present?
      admin_member = AdminMember.find_by(email_for_index: @form.email.downcase)
    end

    if Staff::Authenticator.new(admin_member).authenticate(@form.password)
      session[:admin_member_id] = admin_member.id
      flash.notice = '管理者としてログインしました。'
      redirect_to :admin_root
    else
      flash.now.alert = '管理者アカウントのメールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:admin_member_id)
    flash.notice = '管理者セッションからログアウトしました。'
    redirect_to :admin_root
  end

  private
  def create_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
