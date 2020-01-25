class AddBackgroundColorToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :background_color, :string
  end
end
