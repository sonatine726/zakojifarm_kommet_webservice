class Staff::ProgramsController < Staff::Base
  def index
    @title = 'プログラム管理'
    @programs = Program.listing.page(params[:page])
  end

  def show
    @title = 'プログラム詳細情報'
    @program = Program.listing.find(params[:id])
  end

  def new
    @title = 'プログラムの新規登録'
    @program_form = Staff::ProgramForm.new
  end

  def edit
    @title = 'プログラムの情報更新'
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
  end
end
