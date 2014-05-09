class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.date :started
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
