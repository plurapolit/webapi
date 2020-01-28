class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
