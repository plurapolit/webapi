class CreateIntros < ActiveRecord::Migration[6.0]
  def change
    create_table :intros do |t|
      t.string :audio_file_link
      t.string :file_name

      t.timestamps
    end
  end
end
