class AddAgeRangeToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :age_range
  end
end
