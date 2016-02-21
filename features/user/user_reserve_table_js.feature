@javascript
Feature: User Reserves table
  As user
  I want to access to reserve a table

  Background:
    Given There is an available tables for tomorrow
    And I am a logged user

  @user_reserves_table_for_tomorrow_js 
  Scenario:
    When I reserve a table for tomorrow
    Then I see the table details


  # @user_cancel_table_js @javascript