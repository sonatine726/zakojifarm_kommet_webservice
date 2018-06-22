class StaffMemberPresenter < ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_row
    markup(:tr) do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td do
          m << 
        end
      end
    end
  end
end
