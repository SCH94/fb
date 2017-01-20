require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #home' do
    before :each do
      sign_in @user = create(:user)
      allow(User).to receive(:find).and_return(2)
      allow(Post).to receive(:latest).and_return(latest_posts_collection)
    end # this hook is not necessary if signing in a user is moved to another before :each hook above, since signing-in a user takes care of everything.

    let(:latest_posts_collection) { double 'Latest Posts Collection double' }

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
        allow(Post).to receive(:new).and_return true
        allow(controller.current_user).to receive(:posts)
        allow(controller.current_user.posts).to receive(:build).and_return true
      end

      it 'calls #new on Post' do
        expect(Post).to receive(:new)
        get :home
      end

      it 'makes @post available to the template' do
        get :home
        expect(assigns :post).to eq true 
      end
    end

    describe 'it makes post collection available to the views' do
      it 'calls #latest on Post' do
        expect(Post).to receive(:latest)
        get :home
      end

      it 'makes post collection available to the template' do
        get :home
        expect(assigns :posts).to eq latest_posts_collection
      end
    end

  end
end
