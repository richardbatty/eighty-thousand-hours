Feature: Add donations
  In order to engage users, raise funds and keep track of impact
  As a donations administrator
  I want to create and manage donations
  
  Scenario:
    Given I am a donation admin
    And there is a member
    And there is a charity
    When I create a donation
    Then I should be on the admin donations page
    Then there should be 1 donation
    And the member should be emailed
    And the donation total should not be zero
