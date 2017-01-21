require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'validity of comment' do
    let(:comment) { build :comment }

    it 'not a valid comment'do
      comment.body = nil
      expect(comment).not_to be_valid
    end

    it 'is a valid comment' do
      expect(comment).to be_valid
    end

    it 'is not valid without a commenter' do
      comment.commenter_id = nil
      expect(comment).not_to be_valid
    end

    it 'is not valid without a post' do
      comment.post_id = nil
      expect(comment).not_to be_valid
    end
  end
  
end
