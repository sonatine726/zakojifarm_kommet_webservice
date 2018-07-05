class Customer::EntriesController < Customer::Base
  def create
    program = Program.published.find(params[:program_id])

    ActiveRecord::Base.transaction do
      program.lock!
      case Customer::EntryAcceptor.new(current_customer).accept(program)
      when :accepted
        program.entries.create!(customer: current_customer)
        flash.notice = 'プログラムに申し込みました。'
      when :full
        flash.alert = 'プログラムへの申込者数が上限に達しました。'
      end
    end

    redirect_to [ :customer, program ]
  end
end
