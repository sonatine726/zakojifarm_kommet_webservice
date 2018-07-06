class Customer::ProgramsController < Customer::Base
  def index
    @title = 'プログラム一覧'
    @programs = Program.published.page(params[:page])
  end

  def show
    @title = 'プログラム詳細情報'
    @program = Program.published.find(params[:id])
  end
end
