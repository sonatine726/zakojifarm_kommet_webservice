class Customer::MessagesController < Customer::Base
  def new
    @title = '新規問い合わせ'
    @message = CustomerMessage.new
  end

  #POST
  def confirm
    @title = '新規問い合わせ(確認)'
    @message = CustomerMessage.new(customer_message_params)
    if @message.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = '問い合わせを送信しました。'
        redirect_to :customer_root and return
      else
        flash.now.alert = '入力に誤りがあります。'
      end
    end
    
    render action: 'new'
  end

  private

  def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
end
