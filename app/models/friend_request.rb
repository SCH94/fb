class FriendRequest < ApplicationRecord
  belongs_to :friend_requestor, class_name: 'User'
  belongs_to :requested_friend, class_name: 'User'

  validates :requested_friend_id, presence: true
  validates :friend_requestor_id, presence: true
  validate :duplicate
  validate :friend_request_to_self

  delegate :first_name, :last_name, to: :friend_requestor, prefix: true
  delegate :first_name, :last_name, to: :requested_friend, prefix: true


  private

    def duplicate
      return errors.add :base, message: 'Friend request already exists. Please contact administrator.' if self.new_record? && FriendRequest.where(friend_requestor_id: self.friend_requestor.to_param, requested_friend_id: self.requested_friend.to_param).first
    end

    def friend_request_to_self
      return errors.add :base, message: 'You cannot send a friend request to your self.' if self.friend_requestor == self.requested_friend
    end
end
