class AddFontColorToPanel < ActiveRecord::Migration[6.0]
  def change
    add_column :panels, :font_color, :string
  end
end
