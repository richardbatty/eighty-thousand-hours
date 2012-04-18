Feature: Add donations
  In order to engage users, raise funds and keep track of impact
  As a donations administrator or a site user
  I want to create and manage donations
  
  Scenario:
    Given I am a donation admin
    And there is a member
    And there is a cause
    When I create a donation
    Then I should see the donation
    Then there should be 1 donation
    And the donation total should not be zero
    And the member should be emailed

  Scenario:
    Given I am an 80,000 Hours member
    And I register a donation
    Then I should see the donation
