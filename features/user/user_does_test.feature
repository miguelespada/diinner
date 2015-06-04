Feature: User can do test
  As user
  I want to do test to have better matches

  @user_does_test
  Scenario: User does a test
    Given I am a logged user
    When I do a test
    Then I should be notified that I have done a test
    And I cannot do anymore tests