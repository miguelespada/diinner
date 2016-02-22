@javascript
Feature: User Reserves table
  As user
  I want to access to reserve a table

  Background:
    Given I am a logged user

  @user_reserves_table_for_tomorrow_js 
  Scenario:
    Given There are some available tables for tomorrow
    When I reserve a table for tomorrow
    Then I see the table details

  @user_reserves_table_for_any_day_js
  Scenario:
    Given There are some available tables for any day
    When I reserve a table for any day
    Then I see the table details