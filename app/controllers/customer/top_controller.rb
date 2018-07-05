class Customer::TopController < Customer::Base
  def index
    if current_customer
      @title = 'ダッシュボード'
      render action: 'dashboard'
    else
      @title = 'トップページ'
      render action: 'index'
    end
  end
end
