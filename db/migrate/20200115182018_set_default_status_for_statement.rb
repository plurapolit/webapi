class SetDefaultStatusForStatement < ActiveRecord::Migration[6.0]
  def change
    change_column_default :statements, :status, 0
  end
end
