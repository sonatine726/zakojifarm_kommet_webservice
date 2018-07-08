class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]

  def index
    @title = '全メッセージ一覧'
    @messages = Message.where(deleted: false).page(params[:page])
  end

  #GET
  def inbound
    @title = '問い合わせ一覧'
    @messages = CustomerMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  #GET
  def outbound
    @title = '返信一覧'
    @messages = StaffMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  #GET
  def deleted
    @title = 'メッセージ一覧(ゴミ箱)'
    @messages = Message.where(deleted: true).page(params[:page])
    render action: 'index'
  end
  
  #GET
  def count
    render plain: CustomerMessage.unprocessed.count
  end

  def show
    @title = 'メッセージ詳細'
    @message = Message.find(params[:id])
  end

  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = '問い合わせを削除しました。'
    redirect_back(fallback_location: staff_messages_path)
  end
end
