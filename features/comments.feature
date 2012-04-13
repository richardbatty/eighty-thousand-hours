Feature: Comments
  In order to add my voice to the conversation
  As a user of the site
  I want to add comments to blog posts
  
  Background:
    Given I am signed in
    And there is a post
    And I am viewing the post

  Scenario: Add a comment
    When I enter a comment
    Then I should see the comment
