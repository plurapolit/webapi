class CreateAgeRanges < ActiveRecord::Migration[6.0]
  def change
    create_table :age_ranges do |t|
      t.integer :start_age
      t.integer :end_age

      t.timestamps
    end
  end
end
