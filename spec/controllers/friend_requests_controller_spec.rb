require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  describe 'POST #create' do
    it 'redirects to :index' do
      sign_in(user = create(:user))
      post :create, params: { user_id: user.to_param }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
      expect(flash).not_to be_empty
    end
  end

end
