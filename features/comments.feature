Feature: Comments
  As a user of facebook
  In order to express my reactions to what people are sharing
  I want to comment on their posts

  Background:
    Given a user Pepe Bas has a post
    And user "Loren Burgos" is logged in
    And "Pepe Bas" is friends with "Loren Burgos"

    Scenario: Comment on a post
      Given I am on the homepage
      And I fill in "Write a comment..." under post "Yay! I a" with "Let's go out!"
      And I click on "Comment" button
      Then I should see "Let's go out!" under post "Yay!"
      And I should still be on the homepage
