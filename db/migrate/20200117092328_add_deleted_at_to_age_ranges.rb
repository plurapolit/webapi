class AddDeletedAtToAgeRanges < ActiveRecord::Migration[6.0]
  def change
    add_column :age_ranges, :deleted_at, :datetime
    add_index :age_ranges, :deleted_at
  end
end
