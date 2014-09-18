class AddToImportLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :to_import_location, :string
  end
end
