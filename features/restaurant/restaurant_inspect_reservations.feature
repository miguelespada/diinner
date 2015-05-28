Feature: Restaurant manage reservations
  As restaurant
  I want to manage reservations

  Background:
    Given A user has reserved a table
    When I login as restaurant
    Then I can see the user reservation

  @restaurant_inspect_reservation
  Scenario:
    And I can see the slots left of the reserved table

  @restaurant_validates_reservation
  Scenario:
    Then I can validate the reservation