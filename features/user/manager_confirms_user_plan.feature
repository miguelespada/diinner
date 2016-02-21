Feature: Table manager confirms table
  As user
  I want to get notified when the table manager confirms my plan

  Background:
    Given I am a logged user
    And I will expect a plan confirmation notification 
    And There are some available tables for tomorrow
    And There is a plan closed for tomorrow
    And I make a reservation

  @manager_confirms_reservation
  Scenario:
    When the table manager process runs
    Then I can see the confirmation notification
