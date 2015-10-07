class AddAssetToEvents < ActiveRecord::Migration
  def change
    add_column :events, :asset, :string
  end
end
