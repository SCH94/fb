require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  let!(:comment) { create(:comment, commenter: create(:user, first_name: 'Laura', last_name: 'Tarsi')) }

  describe 'concatenates names' do
    it "concatenates commenter's first and last names" do
    expect(commenter(comment)).to eq 'Laura Tarsi'
    end
  end
end