Feature: Restaurant manage reservations
  As restaurant
  I want to manage reservations

  Background:
    Given A user has reserved a table

  @restaurant_inspect_reservation
  Scenario:
    When I login as restaurant
    And I can see the user reservation
    And I can see the slots left of the reserved table