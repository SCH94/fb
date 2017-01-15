Given(/^I go to "([^"]*)"'s profile page$/) do |arg1|
  arg1 = User.find_by_first_name(arg1.capitalize)
  visit "/users/#{arg1.id}"
end
