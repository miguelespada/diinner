Feature: Admin Inspect Tables
  As admin
  I want to inspect restaurant tables

  Background:
   Given I am logged as admin

  @inspect_restaurant_tables
  Scenario: 
    Given a restaurant has created a table
    Then I should see the table in the tables list