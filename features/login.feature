Feature: Login
  In order to protect our users
  As a user
  I want to login
  
  Scenario: Successful login
    Given I am already registered with the email address "maggie@ekohe.com"
    When I go to the homepage
    And I follow "Login"
    And I fill in "Email" with "maggie@ekohe.com"  
    And I fill in "Password" with "blabla"
    And I press "Login"
    Then I should see "Login success."
  
    
  Scenario: Invalid password login
    Given I am already registered with the email address "maggie@ekohe.com"
    When I go to the homepage
    And I follow "Login"
    And I fill in "Email" with "maggie@ekohe.com"  
    And I fill in "Password" with "jiade"
    And I press "Login"
    Then I should not see "Login success."
    And I should see "Password is not valid"
  