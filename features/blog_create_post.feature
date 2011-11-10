Feature: Create Blog Post
  In order discuss issues
  As a veteran member
  I want to send a message 
  
  Scenario: Successful blog post
    Given I am signed in
    And I am in the blog admin
    When I click "Create Post"
    And I enter my message
    Then then show me the page
    And I should see "Post Created!"
    And there should be 1 post
