Then(/^I should still be on "([^"]*)"'s post "([^"]*)" page$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  post = Post.find_by(content: arg2, user_id: arg1.id)
  expect(page).to have_current_path "/posts/#{post.id}"
end

When(/^I click on "([^"]*)" button on post "([^"]*)"$/) do |arg1, arg2|
  within '.post', text: arg2 do
    click_button arg1
  end
end

Then(/^I should see "([^"]*)" on "([^"]*)" post$/) do |arg1, arg2|
  within '.post', text: arg2 do
    expect(page).to have_text arg1
  end
end
