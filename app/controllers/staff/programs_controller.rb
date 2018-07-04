class Staff::ProgramsController < Staff::Base
  def index
    @title = 'プログラム管理'
    @programs = Program.listing.page(params[:page])
  end

  def show
    @title = 'プログラム詳細情報'
    @program = Program.listing.find(params[:id])
  end
end
