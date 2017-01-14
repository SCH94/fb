require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #home' do
    it 'returns http success when user is signed in' do
      user = create :user
      sign_in user
      get :home
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect when there is no signed in user' do
      get :home
      expect(response).to have_http_status(:redirect)
    end

    it "should have a current_user" do
      user = create :user
      sign_in user
      expect(controller.current_user).to_not eq(nil)
    end
  end

end
