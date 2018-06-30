class AlterCustomers1 < ActiveRecord::Migration[5.1]
  def change
    change_table :customers do |t|
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_mday

      t.index [ :birth_year, :birth_month, :birth_mday ]
      t.index [ :birth_month, :birth_mday ]
      t.index :given_name_kana
      t.index [ :birth_year, :family_name_kana, :given_name_kana ], name: 'index_customers_on_birth_year_and_furigana'
      t.index [ :birth_year, :given_name_kana ]
      t.index [ :birth_month, :family_name_kana, :given_name_kana ], name: 'index_customers_on_birth_month_and_furigana'
      t.index [ :birth_month, :given_name_kana ]
      t.index [ :birth_mday, :family_name_kana, :given_name_kana ], name: 'index_customers_on_birth_mday_and_furigana'
      t.index [ :birth_mday, :given_name_kana ]
    end
  end
end
