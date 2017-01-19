require 'rails_helper'

RSpec.describe Friend, type: :model do
  let(:user1) { User.find_for_authentication(email: 'pEpE.bas@example.com') }
  let(:user2) { User.find_for_authentication(email: 'LorEn.Burgos@exapmle.com') }
  let(:friend_relationship) { create :friend }

  it 'is a valid friend relationship' do
    expect(friend_relationship).to be_valid
  end

  it 'is not a valid friend_relationship' do
    friend_relationship.friender = nil
    expect(friend_relationship).not_to be_valid
  end

  it 'is not a valid friend_relationship' do
    friend_relationship.friendee = nil
    expect(friend_relationship).not_to be_valid
  end

  it 'is not a valid friend_relationship' do
    friend_relationship_blank = Friend.new
    expect(friend_relationship_blank).not_to be_valid
  end

  it 'invalidates duplicates' do
    duplicate_friend_relationship = Friend.new friender: user2, friendee: user1 
    expect(duplicate_friend_relationship).not_to be_valid
  end
end
