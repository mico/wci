class CreateTeachersEvents < ActiveRecord::Migration
  def change
    create_table :events_teachers do |t|
      t.integer :teacher_id
      t.integer :event_id
    end
  end
end
