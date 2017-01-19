Feature: Accept Friend Request
  As a facebooker
  In order to be friends with other facebookers
  I want to accept their friend requests

  Background:
    Given a user "Loren Burgos" added "Pepe Bas" as a friend
    And I am logged in as "Pepe Bas"

    Scenario: Friend requests page
      Given I am on the profile page
      And I click on "Friends"
      And I click on "Friend requests"
      Then I should see "Loren Burgos" under "Respond to your"
      And I should see "Confirm" and "Delete request" buttons under "Loren Burgos"

    Scenario: Accept friend request
      Given I am on the Friend requests page
      When I click on "Confirm" button under "Loren Burgos"
      Then I should still be on the friend requests page and see "You are now friends with Loren Burgos"
      And I should not see "Loren Burgos" under "Respond to your"

    Scenario: Delete friend request
      Given I am on the Friend requests page
      When I click on "Delete request" button under "Loren Burgos"
      Then I should still be on the friend requests page and see "Deleted friend request by Loren Burgos"
      And I should not see "Loren Burgos" under "Respond to your"
