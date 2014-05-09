class RemoveFieldTeacherIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :teacher_id, :integer
  end
end
