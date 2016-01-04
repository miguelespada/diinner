Feature: User test
  As admin
  In order to do a user profile
  I want to see user test responses

  Background:
    Given A user has done a test
    When  I am logged as admin

#  @admin_inspect_test #TODO BUGGY
#  Scenario: User do a test
#    Then I can see the test response
#    And I can see the user test responses

  @safe_delete_test
  Scenario: User do a test
    When I delete a test
    Then I cannot see the test response