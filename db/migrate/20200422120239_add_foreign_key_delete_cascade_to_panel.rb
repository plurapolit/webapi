class AddForeignKeyDeleteCascadeToPanel < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :statements, :panels
    add_foreign_key :statements, :panels, on_delete: :cascade
  end
end
