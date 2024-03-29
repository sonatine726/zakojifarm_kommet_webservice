class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]
  protect_from_forgery except: :tag

  def index
    @title = '全メッセージ一覧'
    @messages = Message.where(deleted: false)
    narrow_down
    @messages = @messages.page(params[:page])
  end

  #GET
  def inbound
    @title = '問い合わせ一覧'
    @messages = CustomerMessage.where(deleted: false)
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  #GET
  def outbound
    @title = '返信一覧'
    @messages = StaffMessage.where(deleted: false)
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  #GET
  def deleted
    @title = 'メッセージ一覧(ゴミ箱)'
    @messages = Message.where(deleted: true)
    narrow_down
    @messages = @messages.page(params[:page])
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

  #POST/DELETE
  def tag
    message = CustomerMessage.find(params[:id])
    if request.post?
      message.add_tag(params[:label])
    elsif request.delete?
      message.remove_tag(params[:label])
    else
      raise
    end

    render plain: 'OK'
  end

  private

  def narrow_down
    if params[:tag_id]
      @messages = @messages.joins(:message_tag_links).where('message_tag_links.tag_id' => params[:tag_id])
    end
  end
end
