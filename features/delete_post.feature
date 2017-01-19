Feature: Delete posts
  As a user of facebook
  In order not be embarrassed
  I want to delete my post(s)

  Background:
    Given a user "Pepe Bas" is logged in

  Scenario: Delete own's post
    And user "Pepe Bas" has a post "Yay! I am on facebook!"
    When I go to "Pepe Bas"s post "Yay! I am on facebook!"
    And I click on "Delete" button
    Then I should be on the profile page
    And I should see "Post deleted."

  Scenario: Delete other's posts
    Given a user "Loren Burgos" exists with a post "Yay!"
    When I go to "Loren Burgos"s post "Yay!"
    And I click on "Delete" button
    Then I should be logged out with the message "You are not authorized to do that action."
    And I should be on the sign in page
