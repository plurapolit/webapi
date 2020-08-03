class DropRoomsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :room_users
  end
end
