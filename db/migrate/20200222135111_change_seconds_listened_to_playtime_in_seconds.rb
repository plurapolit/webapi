class ChangeSecondsListenedToPlaytimeInSeconds < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_audio_trackings, :seconds_listened, :playtime_in_seconds
  end
end
