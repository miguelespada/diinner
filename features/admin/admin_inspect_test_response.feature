Feature: User test
  As admin
  In order to do a user profile
  I want to see user test responses

  @admin_inspect_test
  Scenario: User do a test
    Given A user has done a test
    When  I am logged as admin
    Then I can see the test response
    And I can see the user test responses
