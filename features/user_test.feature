Feature: User test
  As user
  I want to do tests

  Background:
    Given I am a logged user

  @user_do_test
  Scenario: I can do a test
    When I go to the test page
    When I do a test
    Then I should have a test done
