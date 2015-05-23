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

  @charge_reservation
  Scenario:
    When I process reservations
    Then I can see that the reservation is paid