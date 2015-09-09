Feature: Admin inspect evaluations
  As admin
  I want to see the restaurant evaluations

  Background:
    Given A user has evaluated a plan
    Then I am logged as admin

  @admin_inspect_evaluations
  Scenario:
    Then I can see the evaluation
    Then I can access the evaluation through the restaurant page
    Then I can access the evaluation through the menu
