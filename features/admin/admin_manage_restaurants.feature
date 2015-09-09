@admin_manage_restaurants
Feature: Admin Manage Restaurants
  As admin
  I want to manage restaurants

  Background:
    Given I am logged as admin
    When I create a new restaurant

  @admin_create_restaurant
  Scenario: I create a restaurant
    Then I should see the restaurant in the list of restaurants
    Then I should be notified that the restaurant is created

  @admin_edit_restaurant
  Scenario: I edit a restaurant
    When I edit a restaurant
    Then I should see the updated restaurant in the list of restaurants

  @admin_delete_restaurant
  Scenario: I delete a restaurant
    When I delete a restaurant
    Then I should not see the restaurant in the list of restaurants
    Then I should not see the restuarant notifications

  @safe_delete_restaurant
  Scenario: I delete a restaurant
    Given There are some reservations
    When I delete a restaurant
    Then I cannot delete the restaurant