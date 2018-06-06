class Staff::Admin::TopController < Staff::Admin::Base
  def index
    @title = '管理者トップページ'
    render action: 'index'
  end
end