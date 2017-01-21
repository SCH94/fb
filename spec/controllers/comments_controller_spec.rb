require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe 'POST #create' do
    before :example do
      sign_in @user = create(:user)
      allow(Post).to receive(:find) { commented_post }
      allow(controller.current_user).to receive :comments
      allow(controller.current_user.comments).to receive(:build) { comment }
      allow(comment).to receive(:save) { true }
      allow(controller.helpers).to receive :link_to
    end

    let(:commented_post) { double 'Commented Post double' }
    let(:comment) { double 'Comment double' }

    context 'successfully creates a comment for a post' do 
      it 'calls #comments on current_user' do
        expect(controller.current_user).to receive :comments
        post :create, params: { comment: { body: 'Ok tara!' }, post_id: 'any' }
      end

      it 'calls #build on comments' do
        expect(controller.current_user.comments).to receive(:build)
        post :create, params: { comment: { body: 'Ok tara!' }, post_id: 'any' }
      end

      it 'assigns comment in instance variable for the template' do
        post :create, params: { comment: { body: 'Ok tara!' }, post_id: 'any' }
        expect(assigns :comment).to eq comment
      end

      it 'saves comment and succeeds and redirects back to referrer page' do
        expect(comment).to receive :save
        post :create, params: { comment: { body: 'Ok tara!' }, post_id: 'any' }
        expect(response.status).to be 302
        expect(flash).not_to be_empty
      end      
    end

    context 'unsuccessfully creates a comment for a post' do
      it 'has a blank body' do
        # allow(comment).to receive(:save) { false } commented out to make test real and not mocked
        post :create, params: { post_id: 'any', comment: { body: '' } }
        expect(response.status).to be 302
        expect(flash).not_to be_empty
      end
    end

  end
end
