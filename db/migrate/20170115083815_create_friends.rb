class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.references :friender, foreign_key: { to_table: :users }
      t.references :friendee, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
