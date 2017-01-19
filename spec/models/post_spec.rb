require 'rails_helper'

RSpec.describe Post, type: :model do

  describe '#create' do

    describe 'post validity' do

      let(:post) { create :post }

      it 'is a valid post' do
        expect(post).to be_valid 
      end

      it 'is not a valid post' do
        post.content = nil
        expect(post).not_to be_valid
      end

      it 'is not a valid post with no user' do
        post.user_id = nil
        expect(post).not_to be_valid
      end
    end

  end

  describe '#destroy' do
    describe 'it checks database integrity' do
      let!(:post) { create :post }

      it 'makes sure post is gone' do
        expect{post.destroy}.to change(Post, :count).by -1  
      end
    end
  end
end
