class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.integer :location_id
      t.integer :event_type_id
      t.integer :teacher_id
      t.date :date

      t.timestamps
    end
  end
end
