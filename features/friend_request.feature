Feature: Friend Request
  As a facebook user
  In order to start socializing
  I want to add friends

  Background:
    Given a user "Pepe Bas" is logged in
    And a user "Loren Burgos" exists

  Scenario: Add a friend
    And I go to "loren"'s profile page
    Then I should see "Hi Loren"
    When I click on "Add friend" button
    Then I should be on the home page
    And I should see "Friend request sent"
