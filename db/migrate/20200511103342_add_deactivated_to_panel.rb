class AddDeactivatedToPanel < ActiveRecord::Migration[6.0]
  def change
    add_column :panels, :deactivated, :boolean, default: false
    Panel.update_all(deactivated: false)
  end
end
