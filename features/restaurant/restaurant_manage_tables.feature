Feature: Restaurant manage tables
  As restaurant
  I want to manage tables

  Background:
    Given I am logged as restaurant
    When I create a new table

  @restaurant_create_table
  Scenario: I create a new table
    Then I should see the table in the list of tables

  @restaurant_edit_table
  Scenario: I edit a table
    When I edit a table
    Then I should see the updated table in the list of tables

  @restaurant_delete_table
  Scenario: I delete a table
    When I delete a table
    Then I should not see the table in the list of tables