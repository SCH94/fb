require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  it 'concats first and last name' do
    post = build :post 
    expect(post_owner(post)).to eq 'Pepe Bas'
  end

end
