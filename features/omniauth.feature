@omniauth
Feature: Omniauth
  In order to login conveniently
  As a site visitor
  I want to authenticate with Facebook

  Scenario: Signed in and link account
    Given I am signed in
    And I am on my account settings page
    When I connect to Facebook
    Then I have a new authentication
    And I can see the authentication on my account settings page

  Scenario: Sign in with authentication
    Given I have an account
    And I have an authentication
    And I am on the sign in page
    When I connect to Facebook
    Then I am logged in

  Scenario: Link with matching email
    Given I have an account
    And my Facebook email is the same as my account email
    And I am on the sign in page
    When I connect to Facebook
    Then I am logged in

  Scenario: Merge with existing account
    Given I have an account
    And I am on the sign in page
    When I connect to Facebook
    And I merge my account
    Then I am logged in
    And I have a new authentication

  Scenario: Create a new account via authentication
    Given I am an unknown visitor
    And I am on the sign in page
    When I connect to Facebook
    And I create an account
    Then I am logged in
    And I get an email
