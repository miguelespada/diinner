Feature: Admin Inspect Tables
  As admin
  I want to inspect restaurant tables

  @inspect_restaurant_tables
  Scenario:
    Given I am logged as admin
    When a restaurant has created a table
    Then I should see the table in the tables list
    And I can access to the table data
