Feature: User manage preferences
  As user
  I want to manage my search preferences

  Background:
    Given I am a logged user

  @user_edit_preferences
  Scenario:
    When I change my preferences
    Then I see my preferences applied to the table search
