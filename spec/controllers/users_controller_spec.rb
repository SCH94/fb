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

      before :each do
        allow(User).to receive(:find).and_return(2)
        allow(controller.current_user).to receive(:posts)
        allow(controller.current_user.posts).to receive(:build).and_return true
      end

      context 'it makes @user available to template' do
        it 'calls find on User' do
          expect(User).to receive(:find)
          get :show, params: { id: @user.to_param } 
        end

        it 'assigns resource to @user' do
          get :show, params: { id: @user.to_param }
          expect(assigns :user).to eq(2)
        end
      end

      context 'it makes @post available to template' do
        it 'calls #posts on current_user' do
          expect(controller.current_user).to receive(:posts)
          get :show, params: { id: 'any' }
        end

        it 'calls #build on posts' do
          expect(controller.current_user.posts).to receive(:build)
          get :show, params: { id: 'any' }
        end

        it 'makes @post available to the template' do
          get :show, params: { id: 'any' }
          expect(assigns :post).to eq true 
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
