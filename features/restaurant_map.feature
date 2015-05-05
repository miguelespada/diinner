Feature: Restaurant map
  As restaurant
  I can add an address of my restaurant and see it in the map

  Background:
    Given I am logged as restaurant

  @restaurant_map @javascript
  Scenario: I see a map in the map
    When I visit my profile page
    Then I should see a map

  @restaurant_map @javascript
  Scenario: I update my geolocation
    When I add a geolocation to my profile
    Then I should see my geolocation
    And I should see my location marked in the map

  # TODO solve js problem
  @restaurant_map @javascript
  Scenario: I update my address
    When I add an address to my profile
    Then I should see my geolocation
    And I should see my location marked in the map