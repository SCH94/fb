Feature: Posts text box
  As a user
  In order to share my life
  I want to see the post text box

  Scenario: Post text box locations
    Given a user "Pepe Bas" is logged in
    When I go to the home page
    Then I should see the post text box
    And I go to "Pepe Bas"'s profile page
    Then I should see the post text box
