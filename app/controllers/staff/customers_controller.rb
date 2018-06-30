class Staff::CustomersController < Staff::Base
  def index
    @title = '[スタッフ] 顧客管理'
    @search_form = Staff::CustomerSearchForm.new(search_params)
    @customers = @search_form.search.page(params[:page])
  end

  def show
    @title = '[スタッフ] 顧客詳細情報'
    @customer = Customer.find(params[:id])
  end

  def new
    @title = '[スタッフ] 新規顧客登録'
    @customer_form = Staff::CustomerForm.new
  end

  def edit
    @title = '[スタッフ] 顧客情報編集'
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end

  def create
    @customer_form = Staff::CustomerForm.new
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客を追加しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def update
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客情報を更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = '顧客アカウントを削除しました。'
    redirect_to :staff_customers
  end

  private
  def search_params
    params.require(:search).permit(
      :family_name_kana, :given_name_kana, :birth_year, :birth_month, :birth_mday,
      :address_type, :prefecture, :city, :phone_number
    )
  end
end
