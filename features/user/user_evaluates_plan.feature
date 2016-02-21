@user_evaluates_plan
Feature: User Reserves table
  As user
  I want to evaluate a reservation

  Background:
    Given I am a logged user
    And I will expect a evaluation notification 
    When I had a plan

  Scenario:
    When The diinner has passed
    Then I evaluate the plan
