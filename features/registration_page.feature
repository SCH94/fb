Feature: Sign up page
  As a user
  So that I can sign up to the site
  I want to see that the form is proper and complete

  Scenario Outline: Render sign up form with correct fields/attributes
    Given I am on the sign up page
    Then I should see a form element with name "<Element>"
    And with label "<Label>"

    Examples:
      | Element                     | Label                 |  
      | user[first_name]            | First name            |  
      | user[last_name]             | Last name             |  
      | user[email]                 | Email                 |  
      | user[username]              | Username              |  
      | user[gender]                | Male                  |  
      | user[gender]                | Female                |  
      | user[password]              | Password              |  
      | user[password_confirmation] | Password confirmation |  
