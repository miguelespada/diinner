Feature: Admin Inspect Tables
  As admin
  I want to inspect restaurant tables

  @inspect_restaurant_tables
  Scenario:
    Given I am logged as admin
    When a restaurant has created a table
    Then I should see the table in the tables list

  @inspect_user_table
  Scenario: User reserve a table
    Given A user has reserved a table
    When  I am logged as admin
    Then I can see the reserved table
