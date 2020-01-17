class AddStatementToAudioFile < ActiveRecord::Migration[6.0]
  def change
    add_reference :audio_files, :statement, null: false, foreign_key: true
  end
end
