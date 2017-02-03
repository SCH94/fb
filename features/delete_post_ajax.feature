Feature: Delete posts using AJAX
  As a user of facebook
  In order to have a smooth user experience
  I want to delete a post without refreshing the page

  Background:
    Given a user "Pepe Bas" is logged in
    Given user "Pepe Bas" has a post "Yay! I am on facebook!"

  @javascript
  Scenario: Delete a post using AJAX
    When I go to "Pepe Bas"'s profile page
    And click on "Delete" on post "Yay! I am on facebook!"
    Then I should not see "Yay! I am on facebook!"
