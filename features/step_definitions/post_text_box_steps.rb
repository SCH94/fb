Then(/^I should see the post text box$/) do
  within '.postsbox' do
    expect(page).to have_field 'post[content]'
  end
end
