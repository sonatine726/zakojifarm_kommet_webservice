class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :address, foreign_key: true
      t.string :number, null: false
      t.string :number_for_index, null: false, index: true
      t.boolean :primary, null: false, default: false

      t.timestamps
    end
  end
end
