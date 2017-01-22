require 'rails_helper'

RSpec.describe FriendRequestsHelper, type: :helper do
  let(:user) { create :user } # for use in second example

  describe "concatenates friend requestor's name" do
    it "concats friend requestor's first and last name wrapped in <li> tags" do
      friend_request = create :friend_request
      expect(helper.friend_requestor_name(friend_request)).to eq('<li>Pepe Bas</li>')
    end

    it "concats friend requestor's first and last name wrapped in <li> tags" do
      friend_request = create :friend_request, friend_requestor: (create :user, first_name: 'Valeen', last_name: 'Montenegro'), requested_friend: user
      expect(helper.friend_requestor_name(friend_request)).to eq('<li>Valeen Montenegro</li>')
    end
  end

  describe "concatenates friend requestee's name" do
    it "concats friend requestee's first and last name wrapped in <li> tags" do
      friend_request = create :friend_request
      expect(helper.requested_friend_name(friend_request)).to eq('<li>Loren Burgos</li>')
    end

    it "concats friend requestees's first and last name wrapped in <li> tags" do
      friend_request = create :friend_request, friend_requestor: user, requested_friend: (create :user, first_name: 'Valeen', last_name: 'Montenegro')
      expect(helper.requested_friend_name(friend_request)).to eq('<li>Valeen Montenegro</li>')
    end
  end

  it 'determines if friend has been sent a request already' do
    sign_in user
    @user = create :user, first_name: 'Onggardo', last_name: 'Loschayse'
    expect(helper.request_sent? @user).to eq false
  end
end
