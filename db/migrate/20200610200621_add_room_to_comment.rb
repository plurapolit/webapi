class AddRoomToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :room, null: true
  end
end
