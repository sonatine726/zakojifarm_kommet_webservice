class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    if max = program.max_number_of_participants
      if program.entries.where(canceled: false).count >= max
        return :full
      end
    end

    return :accepted
  end
end