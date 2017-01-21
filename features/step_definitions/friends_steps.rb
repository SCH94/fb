Given(/^"([^"]*)" is friends with "([^"]*)", "([^"]*)" and "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
	steps %{
		Given "#{arg1}" is friends with "#{arg2}"
		Given "#{arg1}" is friends with "#{arg3}"
		Given "#{arg1}" is friends with "#{arg4}"
	}
end

When(/^I visit "([^"]*)"'s friends page$/) do |arg1|
	user = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  visit "/users/#{user.id}/friends"
end

Then(/^I should see his list of friends$/) do
	within '.friendslist', text: 'Friends' do
		@current_user.fb_friends.each do |f|
			expect(page).to have_text "#{f.first_name} | #{f.email} |"
		end
	end
end
