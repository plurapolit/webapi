class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :organisation, null: false, foreign_key: true
      t.integer :role
      t.string :email
      t.string :first_name
      t.string :last_name
      t.text :biography
      t.string :twitter_handle
      t.string :facebook_handle
      t.string :linkedin_handle
      t.string :website_link

      t.timestamps
    end
  end
end
