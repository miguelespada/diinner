Feature: Admin Manage Restaurants
  As admin
  I want to access to manage restaurants

  @create_restaurant
  Scenario: I create a restaurant
    Given I am logged as admin
    When I create a new restaurant
    Then I should see the restaurant in the list of restaurants