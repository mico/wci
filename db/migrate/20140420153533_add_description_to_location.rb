class AddDescriptionToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :description, :text
    add_column :locations, :title, :string
  end
end
