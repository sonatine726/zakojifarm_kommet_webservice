class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :program, foreign_key: true, null: false, index: false
      t.references :customer, foreign_key: true, null: false
      t.boolean :approved, null: false, default: false
      t.boolean :canceled, null: false, default: false

      t.timestamps

      t.index [ :program_id, :customer_id ], unique: true
    end
  end
end
