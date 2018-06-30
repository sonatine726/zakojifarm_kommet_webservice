class AlterAddresses1 < ActiveRecord::Migration[5.1]
  def change
    change_table :addresses do |t|
      t.index [ :type, :prefecture, :city ]
      t.index [ :type, :city ]
      t.index [ :prefecture, :city ]
      t.index :city
    end
  end
end
