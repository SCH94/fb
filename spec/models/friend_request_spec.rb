require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  it 'is a valid friend request' do
    friend_request = create :friend_request
    expect(friend_request).to be_valid
  end

  it 'is an invalid friend request with no requested friend' do
    create :user
    create :user, first_name: "laura"
    friend_request = FriendRequest.new friend_requestor_id: User.first.to_param, requested_friend_id: User.second.to_param
    friend_request.requested_friend_id = nil
    expect(friend_request).not_to be_valid
  end

  it 'is an invalid friend request with no friend requestor' do
    create :user
    create :user, first_name: "laura"
    friend_request = FriendRequest.new friend_requestor_id: User.first.to_param, requested_friend_id: User.second.to_param
    friend_request.friend_requestor = nil
    expect(friend_request).not_to be_valid
  end
end
