class Customer::AccountsController < Customer::Base
  def show
    @title = 'アカウント情報'
    @customer = current_customer
  end

  def edit
    @title = 'アカウントの編集'
    @customer_form = Customer::AccountForm.new(current_customer)
  end

  def confirm
    @title = 'アカウントの更新(確認)'
    @customer_form = Customer::AccountForm.new(current_customer)
    @customer_form.assign_attributes(params[:form])
    if @customer_form.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def update
    @customer_form = Customer::AccountForm.new(current_customer)
    @customer_form.assign_attributes(params[:form])
    if params[:commit]
      if @customer_form.save
        flash.notice = 'アカウント情報を更新しました。'
        redirect_to :customer_account
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'edit'
      end
    else
      render action: 'edit'
    end
  end

end

