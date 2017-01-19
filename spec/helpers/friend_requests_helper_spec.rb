require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FriendRequestsHelper. For example:
#
# describe FriendRequestsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
