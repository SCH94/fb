Feature: Sign up
  As a user
  So that I can start using the site
  I want to create an account

  Background:
    Given I am on the sign up page

  Scenario: Successful signup
    When I fill in registration details
    And I click on "Create Account" button
    Then I should be on the profile page
    And I should see "Welcome to Facebook!" and "Hi Pepe Bas!"

  Scenario: Unsuccessful signup
    When I fill in incorrect or incomplete details
    And I click on "Create Account" button
    Then I should see "prohibited this user from being saved:"
    And I should not be on the profile page

