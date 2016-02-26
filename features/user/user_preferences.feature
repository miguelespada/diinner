@user_preferences @javascript
Feature: User Preferences
  As user
  I want to edit my preferences

  @user_edit_preferences
  Scenario: I can edit my preferences
    Given I am a logged user
    When I edit my preferences
    Then I can see my preferences have been updated
