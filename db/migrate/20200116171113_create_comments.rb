class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :sender, null: false
      t.references :recipient, null: false

      t.timestamps
    end
  end
end
