@user_manage_reservations
Feature: User Reserves table
  As user
  I want to access to reserve a table

  Background:
    Given There are some available tables
    And I am a logged user
    When I reserve a table

  @user_reserves_table
  Scenario: User reserve a table
    Then I can see the reserved table in my calendar
    And I can see the reserved table in my reservations
    And I can access restaurant data
    And I can access menu data

  @user_cancel_reservation
  Scenario: User cancel reservation
    When I cancel my reservation
    Then I see that my reservation is cancelled
    And I should not see the reserved table in my calendar

  @user_saves_default_card
  Scenario: User saves default card
    Then I can see my default card on my profile
    And I can reserve again with the same card

  @user_notification_after_table_cancellation
  Scenario: User notification when table cancellation
    When the table manager process runs
    Then I can see the cancellation notification
    And I should not see the reserved table in my calendar
