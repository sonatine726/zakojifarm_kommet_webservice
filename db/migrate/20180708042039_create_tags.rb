class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :value, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
