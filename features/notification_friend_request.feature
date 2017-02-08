Feature: Friend request notification
  As a user
  In order to approve someone's friend request 
  I want to see a notification of his/her friend request

  Background:
    Given user "Pepe Bas" is logged in 
    And user "Loren Burgos" sent "Pepe Bas" a friend request

  Scenario:
    When I go to the home page
    Then I should see "New friend request" on the navigation bar
