Feature: Restaurant manage tables
  As restaurant
  I want to manage tables

  Background:
    Given I am logged as restaurant
    When I create a new table having a menu

  @restaurant_create_table
  Scenario: I create a new table
    Then I should see the table in the list of tables
    And I can see the table in my calendar

  @restaurant_edit_table
  Scenario: I edit a table
    When I edit a table
    Then I should see the updated table in the list of tables

  @restaurant_delete_table
  Scenario: I delete a table
    When I delete a table
    Then I should not see the table in the list of tables

  @restaurant_create_multiple_tables
  Scenario: I duplicate a table
    When I create multiple tables
    Then I should see there are multiple tables with the same day/hour

  @restaurant_create_repeated_tables
  Scenario: I repeat a table
    When I create a repeated table
    Then I should see there are equal tables in the next weeks at the same hour

  @restaurant_can_delete_multiple_tables
  Scenario: I duplicate a table
    Given I create multiple tables
    When I can delete multiple tables at the time