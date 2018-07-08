class CreateHashLocks < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_locks do |t|
      t.string :table, null: false
      t.string :column, null: false
      t.string :key, null: false

      t.timestamps

      t.index [ :table, :column, :key ], unique: true
    end
  end
end
