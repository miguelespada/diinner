Feature: Restaurant inspect payments
  As restaurant
  I want to see the payments

  Background:
    Given A user has reserved a table
    And There are enough reservations
    When the table manager process runs
    Then I am logged as the reserved restaurant

  @restaurant_inspect_payments
  Scenario:
    Then I can see the restaurant reservation payments