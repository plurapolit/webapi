class AddRegionForeignKeyToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :regions, foreign_key: true
  end
end
