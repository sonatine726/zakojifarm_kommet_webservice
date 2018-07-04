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

  def create
    @program_form = Staff::ProgramForm.new
    @program_form.assign_attributes(params[:form])
    @program_form.program.registrant = current_staff_member
    if @program_form.save
      flash.notice = 'プログラムを登録しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def update
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
    @program_form.assign_attributes(params[:form])
    @program_form.program.registrant = current_staff_member
    if @program_form.save
      flash.notice = 'プログラムを更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end
end
