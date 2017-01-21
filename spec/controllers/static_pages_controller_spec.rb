require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #home' do
    before :each do
     # this hook is not necessary if signing in a user is moved to another before :each hook above, since signing-in a user takes care of everything.
      sign_in @user = create(:user)
      allow(User).to receive(:find).and_return(2)
      allow(Post).to receive(:latest).and_return(latest_posts_collection)
    end

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
        # allow(controller.current_user).to receive(:posts)
        # allow(controller.current_user.posts).to receive(:build).and_return true 
        # these use to be current_user.posts.build but was messing up with the view that the newly instantiated post was being rendered as well. Resorted to Post.new instead.
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
      it 'calls #feed on controller' do
        expect(controller).to receive(:feed) 
        get :home
      end

      it 'makes post collection available to the template' do
        allow(controller).to receive(:feed) { latest_posts_collection }
        get :home
        expect(assigns :posts).to eq latest_posts_collection
      end
    end

    describe 'makes new comment available to the form' do
      it 'calls #new on Comment' do
        expect(Comment).to receive(:new)
        get :home
      end

      it 'assigns it to @comment' do
        allow(Comment).to receive(:new) { true }
        get :home
        expect(assigns :comment).to eq true
      end
    end

  end
end
