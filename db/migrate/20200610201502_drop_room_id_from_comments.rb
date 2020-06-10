class DropRoomIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :room_id
  end
end
