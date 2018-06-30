module SessionControllerModule
  extend ActiveSupport::Concern

  include SessionValidityModule

  included do
    before_action :check_login
    skip_before_action :check_login, only: [:new, :create]
  end

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
        hook_create_suspended(target_member)
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        if @form.remember_me?
          cookies.signed[session_id] = {
            value: target_member.id,
            expires: 1.week.from_now
          }
        else
          cookies.delete(session_id)
          session[session_id] = target_member.id
        end

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
    cookies.delete(session_id)
    session.delete(session_id)
    flash.notice = "#{session_name}セッションからログアウトしました。"
    redirect_to root_url
  end

  protected

  def check_login
    unless current_member
      flash.alert = "#{session_name}としてログインしてください。"
      redirect_to login_url
    end
  end

  private

  def create_params
    params.require(:staff_login_form).permit(:email, :password, :remember_me)
  end

  def current_member
    id = cookies.signed[session_id] || session[session_id]
    if id
      virtual_current_member(id)
    end
  end

  def hook_create_suspended(target_member) end
  def hook_create_success(target_member) end
  def hook_destroy(target_member) end
end
