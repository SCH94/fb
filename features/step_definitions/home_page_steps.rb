Given(/^user "([^"]*)" does not have any friends$/) do |arg1|
  user = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  expect(user.fb_friends).to be_empty
end

Then(/^I should not see any posts$/) do
  within '.home-posts' do
    expect(page).not_to have_selector '.post.content'
  end
end
