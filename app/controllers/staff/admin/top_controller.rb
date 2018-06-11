class Staff::Admin::TopController < Staff::Admin::Base
  def index
    if current_admin_member
      @title = '管理者ダッシュボード'
      render action: 'dashboard'
    else
      @title = '管理者トップページ'
      render action: 'index'
    end
  end
end
