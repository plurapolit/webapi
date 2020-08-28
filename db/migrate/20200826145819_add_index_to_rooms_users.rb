class AddIndexToRoomsUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :rooms_users, :room_id
    add_index :rooms_users, :user_id
  end
end
