Feature: Likes
  As a user
  In order to have fun on facebook
  I want to like posts

  Background:
    Given user "Pepe Bas" is logged in
    And user "Loren Burgos" has a post "Yay! I'm on leave!"

    Scenario: Like a post
      When I go to "Loren Burgos"'s profile page 
      Then I should see "0 likes" on "Yay! I'm on leave!" post
      When I click on "Like" button on post "Yay! I'm on leave!"
      Then I should still be on "Loren Burgos"'s profile page
      And I should see "You like this" on "Yay! I'm on leave!" post
      And I should see "1 like" on "Yay! I'm on leave!" post
