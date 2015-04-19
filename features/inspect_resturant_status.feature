Feature: Admin Manage Restaurants
  As admin
  I want to inspect restaurant activity
  I order to monitor system usage

  @inspect_restaurant
  Scenario: I check a restaurant after it has logger
    Given A restaurant has recently logged
    When I am logged as admin
    Then I should see the restaurant activity