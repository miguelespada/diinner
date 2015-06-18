Feature: User manage notifications
  As user
  I want to delete notifications

  Background:
    Given I am a logged user
    And I have some notifications

  @user_delete_notifications
  Scenario:
    When I delete a notification
    Then I do not see the notification
