require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'DELETE #destroy' do
    before :example do
      sign_in @user = create(:user_with_posts, post_count: 1)
    end

    describe 'it checks database integrity' do
      it 'makes sure post is gone' do
        post = Post.find_by(user_id: @user.to_param)
        expect{delete :destroy, params: { id: post.to_param }}.to change(Post, :count).by -1
      end
    end

    describe 'redirects after destruction' do
      it 'redirects back to where post was deleted' do
        post = Post.find_by(user_id: @user.to_param)
        delete :destroy, params: { id: post.to_param }
        expect(response).to have_http_status :redirect 
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
end
