require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  it 'is a valid friend request' do
    friend_request = create :friend_request
    fr = FriendRequest.first
    expect(fr).to be_valid
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

  it 'is an invalid friend request with no friend requestor and requested_friend_id' do
    create :user
    create :user, first_name: "laura"
    friend_request = FriendRequest.new
    expect(friend_request).not_to be_valid
  end


  context 'no duplicate friend requests' do
    it 'rejects a duplicate friend request' do
      create :friend_request
      friend_requestor = User.find_by_email 'pepe.bas@example.com'
      requested_friend = User.find_by_email 'loren.burgos@example.com'
      friend_request = FriendRequest.new friend_requestor_id: friend_requestor.to_param, requested_friend_id: requested_friend.to_param
      expect(friend_request).not_to be_valid
      expect(friend_request.errors.full_messages).to contain_exactly(message: 'Friend request already exists. Please contact administrator.')
    end

    it 'validates a persisted friend request' do
      create :friend_request
      friend_requestor = User.find_by_email 'pepe.bas@example.com'
      requested_friend = User.find_by_email 'loren.burgos@example.com'
      friend_request = FriendRequest.where(friend_requestor_id: friend_requestor.to_param, requested_friend_id: requested_friend.to_param).first
      expect(friend_request).to be_valid
      expect(friend_request.errors.full_messages).to be_empty 
    end

    it 'accepts a unique friend request' do
      create :friend_request
      user3 = create :user, first_name: 'Dave', last_name: 'Grohl', gender: 'M'
      friend_requestor = User.find_by_email 'pepe.bas@example.com'
      requested_friend = User.find_by_email 'dave.grohl@example.com'
      friend_request = FriendRequest.new friend_requestor_id: friend_requestor.to_param, requested_friend_id: requested_friend.to_param
      expect(friend_request).to be_valid
      expect(friend_request.errors.full_messages).to be_empty
    end
  end
end
