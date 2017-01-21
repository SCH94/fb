Given(/^a user Pepe Bas has a post$/) do
  create :post
end

Given(/^I fill in "([^"]*)" under post "([^"]*)" with "([^"]*)"$/) do |arg1, arg2, arg3|
  within '.post', text: arg2 do
    fill_in id: 'comment_body', placeholder: arg1, with: arg3
  end
end

Then(/^I should see "([^"]*)" under post "([^"]*)"$/) do |arg1, arg2|
  within '.post', text: arg2 do
    expect(page).to have_text arg1
  end
end

Then(/^I should still be on the homepage$/) do
  expect(page).to have_current_path '/'
end