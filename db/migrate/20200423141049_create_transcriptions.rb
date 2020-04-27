class CreateTranscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :transcriptions do |t|
      t.integer :status
      t.text :content
      t.text :job_url
      t.references :statement, null: false, foreign_key: true
      t.string :job_name

      t.timestamps
    end
  end
end
