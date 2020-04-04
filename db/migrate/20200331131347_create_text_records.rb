class CreateTextRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :text_records do |t|
      t.references :statement, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
