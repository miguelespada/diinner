Feature: User can do test
  As user
  I want to do test to have better matches

  @user_does_test
  Scenario: User does a test
    Given I am a logged user
    When I do a test
    And I cannot do anymore tests

  @user_skips_test
  Scenario: User skips a tests