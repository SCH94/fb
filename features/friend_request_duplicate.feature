Feature: No friend request duplicates
  As an administrator of this site
  In order to not have duplicate friend requests from both parties
  I want to check whether a user has been sent a friend request already

  More details:
    If a person has been sent a friend request then what he sees on that person's page is a confirmation of the request.
    He should not be able to send a friend request anymore since he has been sent one.


  Background:
    Given a user "Pepe Bas" exists
