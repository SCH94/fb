require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  before :example do
    sign_in(@curr_user = create(:user))
  end

  context 'requires current_user session checking' do

    describe 'display add friend button based on user' do
      it "checks if profile page is not current user's" do
        @user = create :user, first_name: 'Loren', last_name: 'Burgos'
        expect(helper.facebooker_current_user? @user).to be false
      end

      it "checks if profile page is current user's" do
        @user = @curr_user
        expect(helper.facebooker_current_user? @user).to be true
      end
    end

    describe 'display add friend button if not yet an fb friend' do
      before do
        @user = create :user, first_name: 'Loren', last_name: 'Burgos'
      end

      it 'user is not yet a facebook friend' do
        expect(helper.fb_friend? @user).to be false
      end

      it 'user is already a facebook friend' do
        @curr_user.frienders << @user
        expect(helper.fb_friend? @user).to be true
      end
    end

  end

  describe 'converts gender to English' do
    it 'displays full gender name from abberviation' do
      user = build :user, gender: 'F'
      expect(helper.gender_english(@curr_user)).to eq 'Male'
      expect(helper.gender_english(user)).to eq 'Female'
    end
  end

  describe 'concatenates first name and last name' do
    it 'combines first and last names of user' do
      user = build :user, first_name: 'Borlas', last_name: 'Guerrero'
      expect(helper.facebooker(user)).to eq 'Borlas Guerrero'
    end
  end

  describe 'pluralizes a string and omits the number portion' do
    let(:string) { 'Friend Request' }
    let(:plural_string) { 'Friend Requests' }
    let(:single_count) { 1 }
    let(:plural_count) { 10 }
    let(:zero_count) { 0 }

    it 'is singular if count is 1' do
      expect(helper.omit_number_after_pluralize(single_count, string)).to eq string
    end

    it 'is plural if count is more than 1' do
      expect(helper.omit_number_after_pluralize(plural_count, string)).to eq plural_string
    end

    it 'is plural if count is zero' do
      expect(helper.omit_number_after_pluralize(zero_count, string)).to eq plural_string
    end
  end

end
