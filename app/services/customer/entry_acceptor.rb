class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    raise if Time.current < program.application_start_time

    return :closed if Time.current >= program.application_end_time

    if program.entries.where(customer_id: @customer.id).exists? == false &&
      max = program.max_number_of_participants
      if program.entries.where(canceled: false).count >= max
        return :full
      end
    end

    return :accepted
  end
end