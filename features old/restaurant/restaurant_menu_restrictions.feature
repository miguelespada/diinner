@restaurant_menu
Feature: Restaurant menu restriction
  As restaurant
  I want to manage menus

  Background:
    Given I am logged as restaurant

  @restaurant_create_table_without_menu
  Scenario:
    Then I cannot create a table without menus