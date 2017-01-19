require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before :example do
    sign_in @user = create(:user)
  end

  describe 'GET #home' do
    it 'returns http success when user is signed in' do
      get :home
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect when there is no signed in user' do
      sign_out :user
      get :home
      expect(response).to have_http_status(:redirect)
    end

    it "should have a current_user" do
      expect(controller.current_user).to_not eq(nil)
    end

    describe 'makes post available to the views' do
      before :each do
        allow(controller.current_user).to receive(:posts)
        allow(controller.current_user.posts).to receive(:build).and_return true
      end

      it 'calls #posts on current_user' do
        expect(controller.current_user).to receive(:posts)
        get :home
      end

      it 'calls #build on posts' do
        expect(controller.current_user.posts).to receive(:build)
        get :home
      end

      it 'makes @post available to the template' do
        get :home
        expect(assigns :post).to eq true 
      end
    end
  end

end
