class AllowOrganisationToBeNullForUser < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :organisation_id, true
  end
end
