Given(/^a user "([^"]*)" added "([^"]*)" as a friend$/) do |arg1, arg2|
  step %{a user "#{arg1}" exists}
  requested_friend = User.find_by_first_name(arg2.split.first) || (step %{a user "#{arg2}" exists})
  friend_requestor = User.find_by_first_name(arg1.split.first)
  login_as friend_requestor
  create :friend_request, friend_requestor: friend_requestor, requested_friend: requested_friend
end

Given(/^I am logged in as "([^"]*)"$/) do |arg1|
  first_second_name = arg1.split[0..-2].join(' ')
  user = User.find_by_email("#{first_second_name.split.first.downcase}.#{arg1.split.last.downcase}@example.com") || (step %{a user "#{arg1}" exists})
  login_as user
  @current_user = user
end

Then(/^I should see "([^"]*)" under "([^"]*)"$/) do |arg1, arg2|
  within '.friend-requests', text: arg2 do
    expect(page).to have_text arg1
  end
end

Then(/^I should see "([^"]*)" and "([^"]*)" buttons under "([^"]*)"$/) do |arg1, arg2, arg3|
  within '.friendrequest', text: arg3 do
    expect(page).to have_button arg1
    expect(page).to have_button arg2
  end
end

Given(/^I am on the Friend requests page$/) do
  visit "/users/#{@current_user.id}/friend_requests"
end

When(/^I click on "([^"]*)" button under "([^"]*)"$/) do |arg1, arg2|
  within '.friendrequest', text: arg2 do
    click_button arg1
  end
end

Then(/^I should not see "([^"]*)" under "([^"]*)"$/) do |arg1, arg2|
  within '.friend-requests', text: arg2 do
    expect(page).not_to have_text arg1
  end
end

Then(/^I should still be on the friend requests page and see "([^"]*)"$/) do |arg1|
  expect(page).to have_current_path "/users/#{@current_user.id}/friend_requests"
  expect(page).to have_content arg1
end
