class Staff::TopController < Staff::Base
  def index
    @title = '職員トップページ'
    render action: 'index'
  end
end