Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I go to the home page$/) do
  visit '/'
end

Given(/^I click on "([^"]*)"$/) do |arg1|
  click_link arg1
end

When(/^I click on "([^"]*)" button$/) do |arg1|
  click_button arg1
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content arg1
end

Then(/^I should see "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
  expect(page).to have_text arg1
  expect(page).to have_text arg2
end

Then(/^I should see a form element with name "([^"]*)"$/) do |arg1|
  expect(page).to have_field arg1
end

Then(/^with label "([^"]*)"$/) do |arg1|
  page.find 'label', text: arg1, match: :prefer_exact 
end

