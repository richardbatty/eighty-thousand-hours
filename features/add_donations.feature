Feature: Add donations
  In order to engage users, raise funds and keep track of impact
  As a confirmed member of 80,000 Hours
  I want to create and manage my donations
  
  Scenario:
    Given I am an 80,000 Hours member
    And I am signed in
    And there is a cause
    And I create a donation
    Then I should see the donation
