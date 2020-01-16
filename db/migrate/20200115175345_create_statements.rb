class CreateStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :statements do |t|
      t.references :panel, null: false, foreign_key: true
      t.references :audio_file, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :quote
      t.integer :status

      t.timestamps
    end
  end
end
