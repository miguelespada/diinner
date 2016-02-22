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

  @user_reserves_table_with_company_1
  Scenario:
    Given There are some available tables for tomorrow
    When I reserve a table for tomorrow with company 1
    Then I see the table details with company 1

  @user_reserves_table_with_company_2
  Scenario:
    Given There are some available tables for tomorrow
    When I reserve a table for tomorrow with company 2
    Then I see the table details with company 2

  @user_reserves_table_with_payment_errors
  Scenario:
    Given There are some available tables for tomorrow
    When I reserve a table for tomorrow with payment errors
    Then I see there is an error with the payment