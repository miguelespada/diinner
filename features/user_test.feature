Feature: User test
  As user
  I want to do tests

  Background:
    Given I am a logged user
    Given A test has been created

  @user_do_test
  Scenario: I can do a test
    When I go to the test page
    When I do a test
    Then I should have a test done

  @user_cant_do_test
  Scenario: I cant do a test if i have already done it
    When I have done a test
    Then I cant do the test