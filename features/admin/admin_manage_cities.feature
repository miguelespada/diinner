@admin_manage_cities
Feature: Admin Manage Cities
  As admin
  I want to manage cities

  Background:
    Given I am logged as admin
    When I create a new city

  @admin_create_city
  Scenario: I create a restaurant
    Then I should see the city in the list of cities

  @admin_edit_city
  Scenario: I edit a restaurant
    When I edit a city
    Then I should see the updated city in the list of cities

  @admin_delete_city
  Scenario: I delete a restaurant
    When I delete a city
    Then I should not see the city in the list of cities

  @admin_cannot_delete_non_empty_city
  Scenario: I delete a restaurant
    Given There are some restaurants in the city
    When I delete a city
    Then I cannot delete the city