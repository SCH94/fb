Feature: Posts
  As a user
  In order to share my life
  I want to see the post text box

  Background:
    Given user "Pepe Bas" is logged in

  Scenario: Post text box locations
    When I go to the home page
    Then I should see the post text box
    And I go to "Pepe Bas"'s profile page
    Then I should see the post text box

  Scenario: Create post on the home page
    When I go to the home page
    And I fill in the status box with "HOY Pinoy ako!"
    When I click on "Post" button
    Then I should see "Post created"
    And I should see post "HOY Pinoy ako!"
    And I should be on the home page

  Scenario: Create post on the profile page
    When I go to the profile page
    And I fill in the status box with "HOY Pinoy ako!"
    When I click on "Post" button
    Then I should see "Post created"
    And I should see post "HOY Pinoy ako!"
    And I should be on the profile page
