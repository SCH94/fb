Feature: Sign in 
  As a user
  So that I can mingle with other users
  I want to sign in

  Background:
    Given a user "Laura 'Megaton' Reid" exists and I am on the sign in page

  Scenario: Successful sign in
    When I fill in sign-in details
    And I click on "Log in" button
    Then I should be on the home page
    And I should see "Signed in successfully."
		And I should see "Profile" and "Sign out"

  Scenario: Unsuccessful sign in
    When I fill in invalid credentials
    And I click on "Log in" button
    Then I should see "Invalid Email or password."
		And I should not see "Profile" and "Sign out"
    And I should not be on the home page

  Scenario: Sign-in navigation links
    Given I am logged in as "Laura 'Megaton' Reid"
    And I am on the home page
    When I click on "Profile"
    Then I should be on the profile page
