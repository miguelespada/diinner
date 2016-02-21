@user_evaluates_reservation @wip
Feature: User Reserves table
  As user
  I want to evaluate a reservation

  Background:
    Given There are some available tables
    And I am a logged user
    When I reserve a table

  Scenario:
    When The diinner has passed
#    Then I am notified that I should evalute the plan ##TODO NOTIFICATIONS
    Then I can evaluate the reservation
