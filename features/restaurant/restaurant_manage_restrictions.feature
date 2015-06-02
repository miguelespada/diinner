@restaurant_menu
Feature: Restaurant manage menus restrictions
  As restaurant
  I want to manage menus but there are restrictions

  Background:
    Given A user has reserved a table
    When I login as restaurant

  @restaurant_cant_edit_menu
  Scenario: I cant edit a menu with users
    Then I cant edit the reserved menu

  @restaurant_cant_delete_menu
  Scenario: I cant delete a menu with users
    Then I cant delete the reserved menu


  @restaurant_cant_edit_table
  Scenario: I cant edit a table with users
    Then I cant edit the reserved table

  @restaurant_cant_delete_table
  Scenario: I cant delete a table with users
    Then I cant delete the reserved table