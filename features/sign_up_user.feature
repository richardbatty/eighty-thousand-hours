Feature: Sign Up User
  In order to join HIC
  As a budding member
  I want to sign up
  
  Scenario: Enter Email
    Given A Refinery user exists
    And I am on the home page
    Then show me the page
    When I enter my email address
    And press "Sign up"
    Then I am sent a confirmation email
    And I am on the home page
    And I should see "Thanks"