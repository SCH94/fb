require 'rails_helper'
 
RSpec.describe LikesController, type: :controller do

  describe 'POST #create' do
    before :example do
      allow(Post).to receive(:find).and_return post_likee
      allow(controller.current_user).to receive(:posts_liked)
      allow(controller.current_user.posts_liked).to receive(:include?) { true } 
      allow(controller.current_user).to receive(:likes) { likes_collection }
    end

    let(:post_likee) { double 'Post To Like double' }
    let(:likes_collection) { double 'Likes Collection double', where: likes_with_post_likee }
    let(:likes_with_post_likee) { double 'Likes With Post Likee double', first: existing_like }
    let(:existing_like) { double 'Existing Like double', destroy: nil }

    describe 'to unlike' do
      it 'calls #posts_liked on current_user' do
        expect(controller.current_user).to receive :posts_liked
        post :create, params: { post_id: 'any' }
      end

      it 'calls #include on #posts_liked' do
        expect(controller.current_user.posts_liked).to receive(:include?)
        post :create, params: { post_id: 'any' }
        expect(response).to have_http_status :redirect
      end

      it 'calls #destroy on existing_like' do
        expect(existing_like).to receive :destroy
        post :create, params: { post_id: 'any' }
      end
    end

    describe 'to like' do
      it 'calls #posts_liked on current_user' do
        allow(controller.current_user).to receive(:posts_liked) {[]}
        allow(controller.current_user.posts_liked).to receive(:include?).and_return false
        post :create, params: { post_id: 'any' }
        expect(response).to have_http_status :redirect
      end
    end

  end
end
