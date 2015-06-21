Feature: Adamin inspect evaluations
  As admin
  I want to see the restaurant evaluations

  Background:
    Given A user has evaluated a plan
    Then I am logged as admin

  @admin_inspect_evaluations
  Scenario:
    Then I can see the evaluation