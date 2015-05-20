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
    
  Scenario: I delete a menu
    When I delete a menu
    Then I should not see the menu in the list of my menus