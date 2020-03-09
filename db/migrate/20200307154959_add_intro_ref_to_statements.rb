class AddIntroRefToStatements < ActiveRecord::Migration[6.0]
  def change
    add_reference :statements, :intro, foreign_key: true, optional: true
  end
end
