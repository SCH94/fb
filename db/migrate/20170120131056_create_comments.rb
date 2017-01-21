class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commenter, foreign_key: { to_table: :users }
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
