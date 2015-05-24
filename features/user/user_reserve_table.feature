Feature: User Reserves table
  As user
  I want to access to reserve a table

  Background:
    Given There are some available tables
    And I am a logged user
    When I reserve a table

  @user_reserves_table
  Scenario: User reserve a table
    Then I can see the reserved table in my reservations

  @user_cancel_reservation
  Scenario: User cancel reservation
    When I cancel my reservation
    Then I do not see the reserved table in my reservations