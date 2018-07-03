class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.references :staff_members, column: :registrant_id, foreign_key: true, null: false
      t.string :title, null: false
      t.text :description
      t.datetime :application_start_time, null: false, index: true
      t.datetime :application_end_time, null: false
      t.integer :min_number_of_participants
      t.integer :max_number_of_participants

      t.timestamps
    end
  end
end
