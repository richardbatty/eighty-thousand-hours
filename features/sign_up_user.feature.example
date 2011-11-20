# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Cucumber
Feature: Sign Up User
  In order to join HIC
  As a budding member
  I want to sign up
  
  Background:
    Given I am signed out
    And I am on the home page
    When I click "Sign up"
    When I enter my details
  
  Scenario: Successful Sign up
    When I take the pledge
    And press "Sign up"
    Then I am sent an email
    And I should be on the home page
    # Then show me the page
    And I should see "Great!"
    And there should be 1 user
    
  Scenario: I don't take the pledge
    When I press "Sign up"
    Then I should see "Pledge must be accepted"
    