@wip
Feature: Restaurant restrictions
  As restaurant
  I want to manage menus but there are restrictions

  Background:
    Given A user has reserved a table
    When I login as restaurant

  @restaurant_cant_modify_menu
  Scenario:
    Then I cant modify the reserved menu

  @restaurant_cant_modidy_table
  Scenario:
    Then I cant modify the reserved table