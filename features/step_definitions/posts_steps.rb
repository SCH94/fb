When(/^I fill in the status box with "([^"]*)"$/) do |arg1|
  within '.postsbox' do
    fill_in id: 'post_content', with: arg1 
  end
end
