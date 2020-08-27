class RenameRegionsIdToRegionId < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :regions_id, :region_id
  end
end
