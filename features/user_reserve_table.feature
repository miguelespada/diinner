Feature: User Reserves table
  As user
  I want to access to reserve a table

  @user_reserves_table
  Scenario: User reserve a table
    Given I am a logged user
    And There are some available tables
    When I reserve a table
    Then I can see the reserved table in my reservations