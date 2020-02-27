class ChangeUserAudioTrackingUserReferenceToAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_column :user_audio_trackings, :user_id, :bigint, null: true
  end
end
