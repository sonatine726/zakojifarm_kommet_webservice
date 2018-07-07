class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :staff_member, foreign_key: true
      t.references :root, foreign_key: { to_table: :messages}
      t.references :parent, foreign_key: { to_table: :messages}
      t.string :type, null: false
      t.string :status, null: false, default: 'new'
      t.string :subject, null: false
      t.text :body
      t.text :remarks
      t.boolean :discarded, null: false, default: false
      t.boolean :deleted, null: false, default: false

      t.timestamps

      t.index [ :type, :customer_id ]
      t.index [ :customer_id, :discarded ]
      t.index [ :type, :staff_member_id ]
      t.index [ :customer_id, :deleted, :created_at ], name: 'index_messages_on_c_d_s_c'
      t.index [ :root_id, :deleted, :created_at ]
    end
  end
end
