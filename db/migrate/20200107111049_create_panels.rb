class CreatePanels < ActiveRecord::Migration[6.0]
  def change
    create_table :panels do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.string :short_title
      t.text :description

      t.timestamps
    end
  end
end
