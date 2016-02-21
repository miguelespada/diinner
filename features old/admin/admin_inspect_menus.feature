Feature: Admin Inspect Menus
  As admin
  I want to inspect restaurant menus

  Background:
    When a restaurant has created a menu
    Given I am logged as admin

  @inspect_restaurant_menus
  Scenario:
    Then I should see the menu in the menu list
    And I can access to the menu data

  @inspect_menus_through_restaurants
  Scenario:
    Then I should see the menu in the restaurant data