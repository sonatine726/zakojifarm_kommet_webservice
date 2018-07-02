class Staff::Admin::AllowedSourcesController < Staff::Admin::Base
  def index
    @title = "許可IPアドレス一覧"
    @allowed_sources = AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
    @new_allowed_source = AllowedSource.new
  end
end
