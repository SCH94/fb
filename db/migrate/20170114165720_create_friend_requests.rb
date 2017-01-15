class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
      t.references :friend_requestor, foreign_key: { to_table: :users }
      t.references :requested_friend, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
