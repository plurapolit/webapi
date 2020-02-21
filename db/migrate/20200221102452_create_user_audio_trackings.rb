class CreateUserAudioTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_audio_trackings do |t|
      t.integer :current_position_in_seconds
      t.integer :seconds_listened
      t.references :user, null: false, foreign_key: true
      t.references :statement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
