require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    sign_in(@user = create(:user))
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    describe 'instance variable assignment' do
      context 'it makes @user available to template' do
        it 'calls find on User' do
          expect(User).to receive(:find)
          get :show, params: { id: @user.to_param } 
        end

        it 'assigns resource to @user' do
          allow(User).to receive(:find).and_return(2)
          get :show, params: { id: @user.to_param }
          expect(assigns :user).to eq(2)
        end
      end
    end

    it 'returns http success' do
      allow(User).to receive(:find)
      get :show, params: { id: @user.to_param }
      expect(response).to have_http_status :success
    end

    it 'renders :show template' do
      allow(User).to receive(:find)
      get :show, params: { id: @user.to_param }
      expect(response).to render_template :show
    end
  end

end
