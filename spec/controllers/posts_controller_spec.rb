require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'DELETE #destroy' do
    before :example do
      sign_in @user = create(:user_with_posts, post_count: 1)
    end

    context 'html request' do
      describe 'it checks database integrity' do
        it 'makes sure post is gone' do
          post = Post.find_by(user_id: @user.to_param)
          expect{delete :destroy, params: { id: post.to_param }}.to change(Post, :count).by(-1)
        end
      end

      describe 'redirects after destruction' do
        it 'redirects back to where post was deleted' do
          post = Post.find_by(user_id: @user.to_param)
          delete :destroy, params: { id: post.to_param }
          expect(response).to have_http_status :redirect
        end
      end
    end

    context 'ajax request' do
      describe 'it checks database integrity' do
        it 'makes sure post is gone' do
          post = Post.find_by(user_id: @user.to_param)
          expect{delete :destroy, params: { id: post.to_param }, format: :js}.to change(Post, :count).by(-1)
        end

        it 'does not redirect when post is deleted' do
          post = Post.find_by(user_id: @user.to_param)
          delete :destroy, params: { id: post.to_param }, format: :js
          expect(response).not_to redirect_to "/users/#{@user.to_param}"
          expect(response.status).not_to eq 302
          expect(response).to have_http_status :ok
        end
      end
    end

    describe "does not allow deleting other users' post" do
      let!(:post) { create :post, user: (create :user, first_name: 'Loren', last_name: 'Burgos') } # eager for 1st spec in group

      it 'makes sure post is not gone' do
        expect{delete :destroy, params: { id: post.to_param }}.to change(Post, :count).by 0
      end

      it 'redirects to sign-in page' do
        delete :destroy, params: { id: post.to_param }
        expect(response).to redirect_to '/users/sign_in'
      end
    end

  end

  describe 'POST #create' do

    describe 'create a post' do
      before :example do
        sign_in @user = create(:user)
        allow(controller.current_user).to receive(:posts)
        allow(controller.current_user.posts).to receive(:build).and_return built_post
      end

      let(:built_post) { double 'Post Double', save: true, errors: errors }
      let(:errors) { double 'Error Messages double', full_messages: full_messages }
      let(:full_messages) { double 'Full Messages double', first: { message: 'Buhay ka pa!' } }

      context 'HTML request' do
        it 'calls #posts on current_user' do
          expect(controller.current_user).to receive(:posts)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }
        end

        it 'calls #build on #posts' do
          expect(controller.current_user.posts).to receive(:build)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }
        end

        it 'calls #save on post' do
          expect(built_post).to receive(:save)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }
        end
      end

      context 'AJAX request' do
        it 'calls #posts on current_user' do
          expect(controller.current_user).to receive(:posts)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }, format: :js
        end

        it 'calls #build on #posts' do
          expect(controller.current_user.posts).to receive(:build)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }, format: :js
        end

        it 'calls #save on post' do
          expect(built_post).to receive(:save)
          post :create, params: { user_id: @user.to_param, post: { content: 'Hey'} }, format: :js
        end
      end
    end

  end

end
