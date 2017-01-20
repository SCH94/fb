require 'rails_helper'

RSpec.describe FriendRequestsHelper, type: :helper do
  let(:user) { create :user } # for use in second example

  it "concats friend requestor's first and last name wrapped in <li> tags" do
    friend_request = create :friend_request
    expect(helper.friend_requestor_name(friend_request)).to eq('<li>Pepe Bas</li>')
  end

  it "concats friend requestor's first and last name wrapped in <li> tags" do
    friend_request = create :friend_request, friend_requestor: (create :user, first_name: 'Valeen', last_name: 'Montenegro'), requested_friend: user
    expect(helper.friend_requestor_name(friend_request)).to eq('<li>Valeen Montenegro</li>')
  end
end
