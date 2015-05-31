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

  @restaurant_inspect_reservation_log
  Scenario:
    And I can see the reservation in my notifications
    And I can access reservation data

  @restaurant_validates_reservation
  Scenario:
    Then I can validate the reservation

  @restaurant_notification_after_table_cancellation
  Scenario:
    When the table manager process runs
    Then I can see the table cancellation in my notifications

  @restaurant_notification_after_table_confirmation
  Scenario:
    Given There are enough reservations
    When the table manager process runs
    Then I can see the table confirmation in my notifications