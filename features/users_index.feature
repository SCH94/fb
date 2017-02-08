Feature: All users page
  As a facebooker
  In order to gain more friends
  I want to see a list of all people on Facebook to add them

  Background:
    Given user "Pepe Bas" is logged in
    And a user "Loren Burgos", "Michael Faraday" and "Emily Chan" exist
    And "Pepe Bas" is friends with "Loren Burgos"

    Scenario: View all friend requests for current user
      And I am on the home page
      When I click on "Facebookers" on the navigation panel
      Then I should see "Add friends"
      And I should see user "Michael Faraday" with link "Add friend"
      And I should see user "Emily Chan" with link "Add friend"
      And I should see user "Loren Burgos" with no link "Add friend"
