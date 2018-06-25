class ChangeDatatypeBirthdayOfCustomers < ActiveRecord::Migration[5.1]
  def up
    change_table :customers do |t|
      t.change :birthday, 'date USING CAST(birthday AS date)'
    end
  end

  def down
    change_table :customers do |t|
      t.change :birthday, :string
    end
  end
end
