class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :customer, foreign_key: true
      t.string :type, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :company_name, null: false, default: ''
      t.string :division_name, null: false, default: ''

      t.timestamps

      t.index [ :type, :customer_id ], unique: true
    end
  end
end
