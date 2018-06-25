class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :email_for_index, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :gender
      t.string :birthday
      t.string :hashed_password

      t.timestamps

      t.index :email_for_index, unique: true
      t.index [ :family_name_kana, :given_name_kana]
    end
  end
end
