class FriendRequest < ApplicationRecord
  belongs_to :friend_requestor, class_name: 'User'
  belongs_to :requested_friend, class_name: 'User'

  validates :requested_friend_id, presence: true
  validates :friend_requestor_id, presence: true
end
