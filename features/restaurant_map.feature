Feature: Restaurant map
  As restaurant
  I can add an address of my restaurant and see it in the map

  Background:
    Given I am logged as restaurant

  @restaurant_map
  Scenario: I see a map in my profile
    When I go to my profile page
    Then I should see a map