Then(/^I should see the post text box$/) do
  within '.postsbox' do
    expect(page).to have_field 'post[content]'
  end
end

Then(/^I should see post "([^"]*)"$/) do |arg1|
  within '.post' do
    expect(page).to have_text arg1
  end
end
