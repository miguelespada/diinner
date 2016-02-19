Feature: User Reserves table
  As user
  I want to access to reserve a table

  Background:
    Given There are some available tables
    And I am a logged user

  @user_reserves_table_simple_js @javascript
  Scenario:
    When I reserve a table
    Then I see the confirmation


  # @user_cancel_table_js @javascript