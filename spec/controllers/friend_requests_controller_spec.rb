require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  before do
    sign_in(@user = create(:user, first_name: 'Loren', last_name: 'Burgos', gender: 'F'))
  end

  describe 'POST #create' do
    before do
      allow(controller.current_user).to receive(:sent_friend_requests).and_return(sent_requests)
      allow(User).to receive(:find).and_return(requested)
      allow(friend_request.errors).to receive(:full_messages)
      allow(friend_request.errors.full_messages).to receive(:first).and_return(message: 'Mali tayo!')
    end

    let(:sent_requests) { double 'Sent Friend Requests Double', build: friend_request }
    let(:friend_request) { double 'Friend Requests Double', save: nil, errors: nil }
    let(:requested_friend) { double 'Requested Friend Double' } # not being used
    let(:requested) { create :user }

    context 'create friend request successfully' do

      it 'calls #sent_friend_requests on current user' do
        expect(controller.current_user).to receive(:sent_friend_requests)
        post :create, params: { user_id: @user.to_param, requested_friend_id: 2 }
      end

      it 'calls #build on #sent_friend_requests' do
        expect(controller.current_user.sent_friend_requests).to receive :build
        post :create, params: { user_id: @user.to_param, requested_friend_id: 2 }
      end

      it 'redirects to static_pages#home' do
        # @user2 = create(:user, first_name: 'Laura', last_name: 'Tarsi')
        post :create, params: { requested_friend_id: requested.to_param, user_id: @user.to_param }
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to user_path(requested)
        expect(flash).not_to be_empty
      end
    end


    context 'create friend request unsuccessfully' do
      it 'fails at creating friend requests' do
        post :create, params: { user_id: 'any', requested_friend_id: 2  }
        expect(response).to have_http_status(:redirect)
      end
    end
  end


  describe 'GET #index' do
    it 'renders http status success' do
      get :index, params: { user_id: 'any'}
      expect(response).to have_http_status :success
      expect(response).to render_template :index
    end

    context "makes current user's friend requests available to the views" do
      it 'calls #friend_requests on current user' do
        expect(controller.current_user).to receive(:friend_invitations)
        get :index, params: { user_id: 'any'}
      end

      it '@friend_request available to the template' do
        friend_requests_index = spy 'Friend Requests Spy'
        allow(controller.current_user).to receive(:friend_invitations).and_return(friend_requests_index)
        get :index, params: { user_id: 'any'}
        expect(assigns :friend_invitations).to eq(friend_requests_index)
      end
    end
  end


  describe 'DELETE #destroy' do
    before do
      allow(friend_request).to receive :friend_requestor
    end
    let(:friend_request) { double 'Friend Request Double', destroy: nil, friend_requestor: nil, friend_requestor_first_name: 'Ellen', friend_requestor_last_name: 'Adarna' }

    it 'finds resource' do
      expect(FriendRequest).to receive(:find).and_return(friend_request)
      delete :destroy, params: { id: 'any' }
    end

    it 'calls #destroy on result of fetch' do
      allow(FriendRequest).to receive(:find).with('any').and_return(friend_request)
      delete :destroy, params: { id: 'any' }
      expect(friend_request).to have_received(:destroy)
    end

    it 'checks friend request has been deleted from database' do
      friend_request = create :friend_request, requested_friend: (create :user, first_name: 'Laura', last_name: 'Tarsi', gender: 'F')
      expect{delete :destroy, params: { id: friend_request.to_param }}.to change(FriendRequest, :count).by(-1)
    end
  end
end
