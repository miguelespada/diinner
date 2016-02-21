@restaurant_menu
Feature: Restaurant manage menus
  As restaurant
  I want to manage menus

  Background:
    Given I am logged as restaurant
    When I create a menu

  @restaurant_create_menu
  Scenario: I create a menu
    Then I should see the menu in the list of my menus

  Scenario: I edit a menu
    When I edit a menu
    Then I should see the menu updated

  @restaurant_delete_menu
  Scenario: I delete a menu
    When I delete a menu
    Then I should not see the menu in the list of my menus

  @restaurant_cannot_delete_a_menu
  Scenario: I delete a menu
    When I create a table with this menu
    When I cannot delete the menu