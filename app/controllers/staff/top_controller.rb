class Staff::TopController < Staff::Base
  def index
    if current_staff_member
      @title = '職員ダッシュボード'
      render action: 'dashboard'
    else
      @title = '職員トップページ'
      render action: 'index'
    end
  end
end
