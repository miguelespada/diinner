Feature: Restaurant manage tables
  As restaurant
  I want to manage tables

  Background:
    Given I am logged as restaurant
    When I create a table

  Scenario: I create a table
    Then I should see the table in the list of tables
    
  Scenario: I delete a table
    When I delete a table
    Then I should not see the table in the list of tables