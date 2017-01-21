Feature: Home page
  As a user
  In order to get an overview of what is happening
  I want to see the contents of the home page

  Background:
    Given a user "Pepe Bas" is logged in

    Scenario: View home page
      And user "Pepe Bas" does not have any friends
      When I go to the home page
      Then I should not see any posts