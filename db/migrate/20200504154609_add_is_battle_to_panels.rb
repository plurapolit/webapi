class AddIsBattleToPanels < ActiveRecord::Migration[6.0]
  def change
    add_column :panels, :is_battle, :boolean
  end
end
