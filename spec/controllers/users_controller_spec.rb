require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    sign_in(@user = create(:user))
  end

  describe 'GET #index' do
    let(:collection) { double 'Collection double' }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'assigns collection for use in the view' do
      it 'calls #all on User' do
        expect(User).to receive(:all)
        get :index
      end

      it 'assigns collection to @users' do
        allow(User).to receive(:all)  { collection }
        get :index
        expect(assigns :users).to eq collection
      end
    end

  end

  describe 'GET #show' do

    describe 'instance variable assignment' do

      before :each do
        allow(User).to receive(:find).and_return user
        allow(Post).to receive(:new).and_return true
        allow(Comment).to receive(:new).and_return true
      end

      let(:user) { double 'User Double', posts: user_posts_collection }
      let(:user_posts_collection) { double 'User Posts Collection double', latest: user_latest_posts_collection }
      let(:user_latest_posts_collection) { double "User's Latest Posts Collection double" }

      describe 'it makes @user available to template' do
        it 'calls find on User' do
          expect(User).to receive(:find)
          get :show, params: { id: @user.to_param }
        end

        it 'assigns resource to @user' do
          get :show, params: { id: @user.to_param }
          expect(assigns :user).to eq user
        end

        it 'returns http success' do
          get :show, params: { id: @user.to_param }
          expect(response).to have_http_status :success
        end

        it 'renders :show template' do
          get :show, params: { id: @user.to_param }
          expect(response).to render_template :show
        end
      end

      describe 'it makes @post available to template' do
        it 'calls #new on Post' do
          expect(Post).to receive(:new)
          get :show, params: { id: 'any' }
        end

        it 'makes @post available to the template' do
          get :show, params: { id: 'any' }
          expect(assigns :post).to eq true
        end
      end

      describe "it makes user's post collection available to the views" do
        it 'calls #posts on @user' do
          get :show, params: { id: 'any' }
          expect(assigns :user).to have_received(:posts)
        end

        it 'calls #latest on #posts' do
          get :show, params: { id: 'any' }
          expect(assigns[:user].posts).to have_received(:latest)
        end

        it 'makes post collection available to the template' do
          get :show, params: { id: 'any' }
          expect(assigns :posts).to eq user_latest_posts_collection
        end
      end

      describe 'it creates an instance of comment for the template' do
        it 'calls #new on Comment' do
          expect(Comment).to receive(:new)
          get :show, params: { id: 'any' }
        end

        it 'assigns new comment instance to @comment' do
          get :show, params: { id: 'any' }
          expect(assigns :comment).to eq true
        end
      end
    end
  end
end
