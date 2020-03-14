class AddIsIntroToUserAudioTrackings < ActiveRecord::Migration[6.0]
  def change
    add_column :user_audio_trackings, :is_intro, :boolean, default: false
  end
end
