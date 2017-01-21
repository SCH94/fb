require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'invalidates duplicates' do
    create :like
    duplicate_like = Like.new user: User.find_for_authentication(email: 'LoREN.burGOs@example.com'), post: Post.find_by_content('Woohoow!')
    expect(duplicate_like).not_to be_valid
  end
end
