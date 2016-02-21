@javascript
Feature: I close a last minute plan

  Background:
    Given I am a logged user
    And There is a last minute plan for today
    And There is a new reservation
    And I have preferences

  @user_closes_last_minute
  Scenario:
    When I search a plan for today
    Then I can see the plan confirmation
