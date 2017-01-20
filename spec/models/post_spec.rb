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

  describe '#user_first_name & #user_last_name' do
    before :context do
      @post = build :post
    end

    after :context do
      @post.user.destroy
    end

    it "returns posts's owner's first name" do
      expect(@post.user_first_name).to eq 'Pepe'  
    end

    it "returns' post's owner's last name" do
      expect(@post.user_last_name).to eq 'Bas'
    end
  end

  describe 'posts ordering by latest' do
    it 'sorts posts by latest date' do
      first_post = create :post, content: 'First post!'
      second_post = create :post, content: 'Second post!', user: first_post.user
      expect(Post.latest).to start_with second_post 
      expect(Post.latest).to end_with first_post 
    end
  end
end
