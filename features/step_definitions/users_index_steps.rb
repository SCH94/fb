Given(/^a user "([^"]*)", "([^"]*)" and "([^"]*)" exist$/) do |arg1, arg2, arg3|
  steps %{
    Given a user "#{arg1}" exists
    Given a user "#{arg2}" exists
    Given a user "#{arg3}" exists
  }
end

Then(/^I should see user "([^"]*)" with button "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  within '.facebooker', text: "#{arg1.first_name} #{arg1.last_name}" do
    expect(page).to have_button arg2
  end
end

Then(/^I should see user "([^"]*)" with no button "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  within '.facebooker', text: "#{arg1.first_name} #{arg1.last_name}" do
    expect(page).not_to have_button arg2
  end
end

Then(/^I should see user "([^"]*)" with link "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  within '.facebooker', text: "#{arg1.first_name} #{arg1.last_name}" do
    expect(page).to have_link arg2
  end
end

Then(/^I should see user "([^"]*)" with no link "([^"]*)"$/) do |arg1, arg2|
  arg1 = User.find_for_authentication(email: "#{arg1.split.first}.#{arg1.split.last}@example.com") || (step %{a user "#{arg1}" exists})
  within '.facebooker', text: "#{arg1.first_name} #{arg1.last_name}" do
    expect(page).not_to have_link arg2
  end
end
