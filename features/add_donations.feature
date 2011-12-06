Feature: Add donations
  In order to engage users, raise funds and keep track of impact
  As a donations administrator
  I want to create and manage donations
  
  Scenario:
    Given I am a donation admin
    When I create a donation
    Then there should be 1 donation
    And the member should be emailed
    And the donation total should not be zero
