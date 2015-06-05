@restaurant_menu
Feature: Restaurant menu restriction
  As restaurant
  I want to manage menus

  Background:
    Given I am logged as restaurant

  @restaurant_create_table_without_menu
  Scenario:
    Then I cannot create a table without menus

  @restaurant_cant_create_max_menus @wip
  Scenario: I can't create more than the max of menus
    Given I am logged as restaurant
    And I have created three menus
    Then I should see I can't create more menus

  @restaurant_cant_create_same_price_menus @wip
  Scenario: I can't create two menus of the same type
    Given I am logged as restaurant
    And I have created a 40 price menu
    Then I should see I can't create a 40 price menu again