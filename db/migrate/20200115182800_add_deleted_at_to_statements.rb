class AddDeletedAtToStatements < ActiveRecord::Migration[6.0]
  def change
    add_column :statements, :deleted_at, :datetime
    add_index :statements, :deleted_at
  end
end
