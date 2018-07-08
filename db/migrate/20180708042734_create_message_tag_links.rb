class CreateMessageTagLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :message_tag_links do |t|
      t.references :message, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps

      t.index [ :message_id, :tag_id ], unique: true
    end
  end
end
