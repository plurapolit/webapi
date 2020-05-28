class CreateClickTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :click_trackings do |t|
      t.references :statement, foreign_key: true, optional: true
      t.references :user, foreign_key: true, optional: true
      t.string :event
      t.text :information
    end
  end
end
