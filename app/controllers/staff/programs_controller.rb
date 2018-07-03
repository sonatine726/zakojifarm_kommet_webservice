class Staff::ProgramsController < Staff::Base
  def index
    @title = 'プログラム管理'
    @programs = Program.order(application_start_time: :desc).page(params[:page])
  end

  def show
    @title = 'プログラム詳細情報'
    @program = Program.find(params[:id])
  end
end
