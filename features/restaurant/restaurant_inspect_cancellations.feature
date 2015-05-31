Feature: Restaurant inspect cancellations
  As restaurant
  I want to see when a reservation is cancelled

  Background:
    Given A user has cancelled a reservation
    When I login as restaurant

  @restaurant_inspect_cancellation
  Scenario:
    And I can see the cancellation in my reservations

  @restaurant_inspect_cancellation_log
  Scenario:
    And I can see the cancellation in my notifications