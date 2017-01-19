Feature: Friend Request
  As a facebook user
  In order to start socializing
  I want to add friends

  Background:
    Given a user "Pepe Bas" is logged in
    And a user "Loren Burgos" exists

  Scenario: Add a friend
    And I go to "Loren Burgos"'s profile page
    Then I should see "Loren Burgos"
    When I click on "Add friend" button
    Then I should be on the home page
    And I should see "Friend request sent"

  Scenario: No Add friend button on self's profile page
    And I go to "Pepe Bas"'s profile page
    Then I should not see "Add friend" button

  Scenario: No Add friend button if already friends with user
    Given "Pepe Bas" is friends with "Loren Burgos"
    When I go to "Loren Burgos"'s profile page
    Then I should not see "Add friend" button
    And I should see "You are friends with this person"
