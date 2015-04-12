Feature: Admin Manage Restaurants
  As admin
  I want to access to manage restaurants

  Background:
    Given I am logged as admin
    When I create a new restaurant

  @create_restaurant
  Scenario: I create a restaurant
    Then I should see the restaurant in the list of restaurants

  @delete_restaurant
  Scenario: I delete a restaurant
    When I delete a restaurant
    Then I should not see the restaurant in the list of restaurants
