Feature: Register (team leaders)
  In order to charge them money
  As a team leader
  I want to register

  Scenario: Register
    Given I am not register to the website
    And no emails have been sent
    When I go to the homepage
    And I follow "Sign up"
    And I fill in the following:
    | Email                 | maggie@ekohe.com  |
    | Password              | password123       |
    | Password confirmation | password123       |
    And I press "Sign up"
    And "maggie@ekohe.com" should receive an email
    And I open the email with subject "Activation Instructions"
    And I click the first link in the email
    Then I should see "Your account have been activated!"

  Scenario: Duplicate registration
    Given I am already registered with the email address "maggie@ekohe.com"
    And no emails have been sent
    When I go to the homepage
    And I follow "Sign up"
    And I fill in the following:
    | Email                 | maggie@ekohe.com  |
    | Password              | password123       |
    | Password confirmation | password123       |
    And I press "Sign up"
    Then I should see "There is already an account registered with this email address. Please try again"
    And "maggie@ekohe.com" should receive no emails


