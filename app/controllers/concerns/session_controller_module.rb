module SessionControllerModule
  extend ActiveSupport::Concern

  def new
    @title = "#{session_name} ログイン"
    if current_member
      redirect_to root_url
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(create_params)
    if @form.email.present?
      target_member = target_model.find_by(email_for_index: @form.email.downcase)
    end

    if Staff::Authenticator.new(target_member).authenticate(@form.password)
      if target_member.suspended?
        hook_create_susupended(target_member)
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[session_id] = target_member.id
        session[last_access_time_id] = Time.current
        hook_create_success(target_member)
        flash.notice = "#{session_name}としてログインしました。"
        redirect_to root_url
      end
    else
      flash.now.alert = "#{session_name}アカウントのメールアドレスまたはパスワードが正しくありません。"
      render action: 'new'
    end
  end

  def destroy
    if current_member
      hook_destroy(current_member)
    end
    session.delete(session_id)
    flash.notice = "#{session_name}セッションからログアウトしました。"
    redirect_to root_url
  end

  private

  def create_params
    params.require(:staff_login_form).permit(:email, :password)
  end

  def hook_create_susupended(target_member) end
  def hook_create_success(target_member) end
  def hook_destroy(target_member) end

end
