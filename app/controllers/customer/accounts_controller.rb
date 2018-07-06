class Customer::AccountsController < Customer::Base
  def show
    @title = 'アカウント情報'
    @customer = current_customer
  end

  def edit
    @title = 'アカウントの編集'
    @customer_form = Customer::AccountForm.new(current_customer)
  end


end

