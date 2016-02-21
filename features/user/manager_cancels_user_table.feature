Feature: Table manager cancels table
  As user
  I want to get notified when the table manager cancels my reservation


  Background:
    Given I am a logged user
    And I will expect a plan cancellation notification 
    And There are some available tables for tomorrow
    And I make a reservation

  @manager_cancels_reservation
  Scenario:
    When the table manager process runs
    Then I can see the cancellation notification
