Given(/^I go to "([^"]*)"'s profile page$/) do |arg1|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com")
  visit "/users/#{arg1.id}"
  expect(page).to have_current_path "/users/#{arg1.id}"
end

Then(/^I should not see "([^"]*)" button$/) do |arg1|
  expect(page).not_to have_button arg1
end

Given(/^"([^"]*)" is friends with "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  # email and username are dynamically created in the factory.

  arg2 = User.find_for_authentication(email: "#{arg2.split.first}.#{arg2.split.last}@example.com") || (step %{a user "#{arg2}" exists})
  # email and username are dynamically created in the factory.

  arg1.frienders << arg2
end

Given(/^user "([^"]*)" sent "([^"]*)" a friend request$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  # email and username are dynamically created in the factory.

  arg2 = User.find_for_authentication(email: "#{arg2.split.first}.#{arg2.split.last}@example.com") || (step %{a user "#{arg2}" exists})
  # email and username are dynamically created in the factory.

  arg1.requested_friends << arg2
end

Then(/^I should see "([^"]*)" on the navigation bar$/) do |arg1|
  within '.nav-wrapper' do
    expect(page).to have_text arg1
  end
end
