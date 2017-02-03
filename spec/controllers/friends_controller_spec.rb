require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  describe 'GET #index' do
    before :example do
      allow(User).to receive(:find) { friend }
      allow(friend).to receive(:fb_friends) { true }
    end

    let(:friend) { double 'Friend double' }

    it 'returns http success' do
      get :index, params: { user_id: 'any' }
      expect(response).to have_http_status :success
      expect(response).to render_template :index
    end

    it 'calls find on User' do
      expect(User).to receive(:find) { friend }
      get :index, params: { user_id: 'any' }
    end

    it 'calls #fb_friends on @user' do
      expect(friend).to receive(:fb_friends)
      get :index, params: { user_id: 'any' }
    end

    it 'makes @user available to the template' do
      get :index, params: { user_id: 'any' }
      expect(assigns :user).to eq friend
      
    end

    it 'makes @friends available to the template' do
      get :index, params: { user_id: 'any' }
      expect(assigns :friends).to eq true
    end

  end

  describe 'POST #create' do

    context 'friend request accepted succesfully' do
      before do
        create :friend_request
        sign_in(@user = User.find_by_email('loren.burgos@example.com'))
        create :friend, friender: friender, friendee: @user
        allow(controller.current_user).to receive(:friends)
        allow(controller.current_user.friends).to receive(:build).and_return(friend_relationship)
        allow(FriendRequest).to receive(:where).and_return(friend_request)
        allow(FriendRequest.where.first).to receive(:destroy)
      end

      let(:friender) { User.find_by_email('pepe.bas@example.com') }
      let(:friend_relationship) { Friend.first }
      let(:friend_request) { double 'Friend Request double', destroy: true, first: nil }

      it 'redirects to friend requests page' do
        post :create, params: { user_id: friender.to_param, friender_id: friender.to_param }
        expect(response).to have_http_status :redirect
        expect(flash).not_to be_empty
      end

      context 'makes friend available to the views' do

        let(:friender) { User.find_by_email('loren.burgos@example.com') }

        it 'calls #friends on current user' do
          expect(controller.current_user).to receive(:friends)
          post :create, params: { user_id: friender.to_param }
        end

        it 'calls #build on current_user.friends' do
          expect(controller.current_user.friends).to receive(:build)
          post :create, params: { user_id: friender.to_param }
        end
      end

    end

    context 'friend already requested' do

      it 'raises StandardError if friend relationship is duplicate' do
        create :friend
        sign_in(@user = User.find_by_email('loren.burgos@example.com'))
        expect{post :create, params: { user_id: 1 }}.to raise_exception(StandardError)
        expect(response).to have_http_status 200
      end
    end

  end
end
