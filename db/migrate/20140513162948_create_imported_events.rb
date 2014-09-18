class CreateImportedEvents < ActiveRecord::Migration
  def change
    create_table :imported_events do |t|
      t.string :ical_uid
      t.integer :event_id
    end
  end
end
