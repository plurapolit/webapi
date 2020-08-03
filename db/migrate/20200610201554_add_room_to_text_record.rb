class AddRoomToTextRecord < ActiveRecord::Migration[6.0]
  def change
    add_reference :text_records, :room, null: true
  end
end
