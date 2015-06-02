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

  @restaurant_duplicate_table
  Scenario: I duplicate a table
    When I duplicate a table
    Then I should see there are more tables with the same day/hour

  @restaurant_replicate_table
  Scenario: I replicate a table
    When I replicate a table
    Then I should see there are equal tables in the next days at the same hour
