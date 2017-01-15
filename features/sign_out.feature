Feature: Sign out
  As a user
  So that I can secure my account after use
  I want to log out

  Background:
    Given a user "Pepe Bas" is logged in

  Scenario: Log out
		And I am on the profile page
    When I click on "Sign out"
    Then I should be on the sign in page
		And I should not see "Profile" and "Sign out"
