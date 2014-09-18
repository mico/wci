class AddToImportToEvents < ActiveRecord::Migration
  def change
    add_column :events, :to_import, :boolean, default: false
  end
end
