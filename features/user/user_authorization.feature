Feature: User autorization
  As user
  I am not allowed to edit other user data

  Background:
    Given I am a logged user
    And There is another user

  @user_authorization
  Scenario:
    Then I cannot access other user data
