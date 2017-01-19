Feature: Friends page
  As a facebook user
  In order to see all of my friends
  I want to view all my friends on a page

  Scenario: Go to friends page
    Given a user "Pepe Bas" is logged in
    Given "Pepe Bas" is friends with "Laura Tarsi", "Lauren Conrad" and "Kepyak Manalungkoat"
    When I visit "Pepe Bas"'s friends page
    Then I should see his list of friends

