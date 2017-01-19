Given(/^I am on the home page$/) do
  visit '/'
end

Given(/^I am on the sign up page$/) do
  visit 'users/sign_up'
end

Given(/^I am on the sign in page$/) do
  visit '/users/sign_in'
end

Given(/^I am on the profile page$/) do
	visit "/users/#{@current_user.id}"
end

Given(/^a user "([^"]*)" exists$/) do |arg1|
  first_second_name = arg1.split[0..-2].join(' ')
  last_name = arg1.split.last
  first_name_arr = first_second_name.split
  user = create :user, first_name: first_name_arr.unshift(first_name_arr.shift.capitalize).join(' '), last_name: last_name.capitalize
  # email and username are dynamically created in the factory.
end

Given(/^a user "([^"]*)" is logged in$/) do |arg1|
  first_second_name = arg1.split[0..-2].join(' ')
  last_name = arg1.split.last
  first_name_arr = first_second_name.split
  user = create :user, first_name: first_name_arr.unshift(first_name_arr.shift.capitalize).join(' '), last_name: last_name.capitalize
	login_as user, scope: :user
  # email and username are dynamically created in the factory.
  @current_user = user
end

Given(/^a user "([^"]*)" exists and I am on the sign in page$/) do |arg1|
  steps %{
    Given a user "#{arg1}" exists
    And I am on the sign in page
  }
end

When(/^I fill in valid registration details and click on "([^"]*)" button$/) do |arg1|
  within 'form.new_user' do
    fill_in 'user_first_name', with: 'Pepe'
    fill_in 'user_last_name', with: 'Bas'
    fill_in 'user_email', with: 'pepe.bas@example.com'
    fill_in 'user_username', with: 'pepe'
    choose 'Male'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    step %{I click on "#{}" button}

    @current_user = User.find_for_authentication(email: "pepe.bas@example.com")
  end
end

When(/^I fill in incorrect or incomplete details$/) do
  within 'form.new_user' do
    fill_in 'user_first_name', with: ''
    fill_in 'user_last_name', with: 'Bas'
    fill_in 'user_email', with: 'pepe.bas@example.com'
    fill_in 'user_username', with: 'pepe'
    choose 'Male'
    fill_in 'Password', with: 'foobar'
  end
end

When(/^I fill in sign\-in details$/) do
  user = User.first
  within 'form.new_user' do
    fill_in 'user_email', with: user.email
    fill_in 'Password', with: 'foobar'
  end
end

When(/^I fill in invalid credentials$/) do
  within 'form.new_user' do
    fill_in 'user_email', with: 'pepe.bas@example.com'
    fill_in 'Password', with: 'wrongPassword'
  end
end

Then(/^I should be on the home page$/) do
  expect(page).to have_current_path '/'
end

Then(/^I should not be on the home page$/) do
  expect(page).not_to have_current_path '/'
end

Then(/^I should be on the profile page$/) do
  expect(page).to have_current_path("/users/#{@current_user.id}")
end

Then(/^I should not be on the profile page$/) do
  expect(page).not_to have_text 'Welcome to Facebook!'
end

Then(/^I should be on the sign in page$/) do
  expect(page).to have_current_path '/users/sign_in'
end

Then(/^I should not see "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
	expect(page).not_to have_text arg1
	expect(page).not_to have_text arg1
end
