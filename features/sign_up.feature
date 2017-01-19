Feature: Sign up
  As a user
  So that I can start using the site
  I want to create an account

  Background:
    Given I am on the sign up page

  Scenario: Successful signup
    When I fill in valid registration details and click on "Create Account" button
    Then I should be on the profile page
    And I should see "Welcome to Facebook! You have signed up successfully."

  Scenario: Unsuccessful signup
    When I fill in incorrect or incomplete details
    And I click on "Create Account" button
    Then I should see "prohibited this user from being saved:"
    And I should not be on the profile page

