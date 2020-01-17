class RemoveAudioFileFromStatement < ActiveRecord::Migration[6.0]
  def change
    remove_reference :statements, :audio_file, null: false, foreign_key: true
  end
end
