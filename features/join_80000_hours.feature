Feature: Join 80,000 Hours
  In order to join 80,000 Hours
  As a budding member
  I want to sign up
  
  Scenario: Not signed in
    Given I am signed out
    And I am on the home page
    When I click "Join"
    Then I should be told to signup first

  Scenario: Already signed in
    Given I am signed in
    And I am on the home page
    When I click "Join"
    And I enter my details
    Then I am sent an email
    And I should see "Thanks for your application"
