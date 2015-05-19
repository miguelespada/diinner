Feature: Admin Inspect Reservations
  As admin
  I want to inspect user reservations

  @inspect_user_reservation
  Scenario:
    Given A user has reserved a table
    When I am logged as admin
    Then I can see the user reservation in the table section
    And I can see the user reservation in the reservation section