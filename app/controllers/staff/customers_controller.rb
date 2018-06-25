class Staff::CustomersController < Staff::Base
  def index
    @title = '[スタッフ] 顧客管理'
    @customers = Customer.order(:family_name_kana, :given_name_kana)
      .page(params[:page])
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
end
