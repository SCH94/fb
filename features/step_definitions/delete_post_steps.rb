Given(/^a user "([^"]*)" exists with a post "([^"]*)"$/) do |arg1, arg2|
  step %{a user "#{arg1}" exists}
  arg1 = User.find_by_last_name arg1.split.last
  create :post, user: arg1, content: arg2
end

Given(/^user "([^"]*)" has a post "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  # email and username are dynamically created in the factory.
  
  @post = Post.find_by(content: arg2, user_id: arg1.id) || create(:post, content: arg2, user: arg1)
end

When(/^I go to "([^"]*)"s post "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  @post = Post.find_by(content: arg2, user_id: arg1.id)
  visit "/posts/#{@post.id}"
end

Then(/^I should be logged out with the message "([^"]*)"$/) do |arg1|
  expect(page).to have_text arg1
  visit '/'
end
