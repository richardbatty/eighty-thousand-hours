Feature: Join 80,000 Hours
  In order to join 80,000 Hours
  As a budding member
  I want to sign up
  
  Scenario: Not signed in
    Given I am signed out
    And I am on the home page
    When I click "Join"
    Then I should see the join page
    And I should see "You need to create an account!"

  Scenario: Already signed in
    Given I am signed in
    And I am on the home page
    When I click "Join"
    And I fill in the application form
    Then I am sent an email
    And I should see "Thank you for your interest in 80,000 Hours,"

  Scenario: Already applied
    Given I am signed in
    And I have applied to join 80,000 Hours
    And I am on the home page
    When I click "Join"
    Then I should see the join page
    And I should see "You've already submitted an application!"
