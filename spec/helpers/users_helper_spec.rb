require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do

  describe 'display add friend button based on user' do
    it "checks if profile page is not current user's" do
      sign_in(curr_user = create(:user))
      @user = create :user, first_name: 'Loren', last_name: 'Burgos'
      expect(helper.can_add_user).to be true
    end

    it "checks if profile page is current user's" do
      sign_in(curr_user = create(:user))
      @user = curr_user
      expect(helper.can_add_user).to be false
    end
  end

  describe 'display add friend button if not yet an fb friend' do
    before do
      sign_in(@curr_user = create(:user))
      @user = create :user, first_name: 'Loren', last_name: 'Burgos'
    end

    it 'user is not yet a facebook friend' do
      expect(helper.fb_friend?).to be false
    end

    it 'user is already a facebook friend' do
      @curr_user.frienders << @user
      expect(helper.fb_friend?).to be true 
    end

  end
end
