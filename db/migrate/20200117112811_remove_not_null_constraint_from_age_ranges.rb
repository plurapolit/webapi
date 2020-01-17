class RemoveNotNullConstraintFromAgeRanges < ActiveRecord::Migration[6.0]
  def change
    change_column :age_ranges, :start_age, :integer, null: true
    change_column :age_ranges, :end_age, :integer, null: true
  end
end
