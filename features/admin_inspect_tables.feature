Feature: Admin Inspect Tables
  As admin
  I want to inspect restaurant tables

  Background:

  @inspect_restaurant_tables
  Scenario:
    Given I am logged as admin
    When a restaurant has created a table
    Then I should see the table in the tables list
    And I can access to the table data

  @inspect_user_reservation @wip
  Scenario:
    Given A user has reserved a table
    And I am logged as admin
    Then I can see the reservation