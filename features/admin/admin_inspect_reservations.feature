Feature: Admin Inspect Reservations
  As admin
  I want to inspect user reservations

  Background:
    Given A user has reserved a table
    And I am logged as admin

  @inspect_user_reservation
  Scenario:
    Then I can see the user reservation in the table section
    And I can see the user reservation in the reservation section
    And I can see the reservation in the user section
    And I can see the reservation in the restaurant section
    And I can see the reservation details

  @fail_capture_reservation
  Scenario:
    When I process reservations
    Then I can see that the reservation is cancelled

  @admin_inspect_new_reservation_log
  Scenario:
    Then I should see the log of the new reservation

  @capture_reservation
  Scenario:
    Given There enough reservations
    When I process reservations
    Then I can see that the reservation is paid

  @admin_processes_last_minute
  Scenario:
    Then I can process last minute diinners