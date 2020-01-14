class SetDefaultRoleForUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :role, 0
  end
end
