class CreateAudioFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :audio_files do |t|
      t.string :file_link
      t.integer :duration_seconds

      t.timestamps
    end
  end
end
