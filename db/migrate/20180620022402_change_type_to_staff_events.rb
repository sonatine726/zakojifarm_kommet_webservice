class ChangeTypeToStaffEvents < ActiveRecord::Migration[5.1]
  def up
    change_table :staff_events do |t|
      t.change :type, 'integer USING CAST(type AS integer)', default: 0
    end
  end

  def down
    change_table :staff_events do |t|
      t.change :type, :string
    end
  end
end
