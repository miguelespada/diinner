@javascript
Feature: I reserve a last minute plan

  Background:
    Given I am a logged user
    And There is a last minute plan for today
    And I have preferences

  @user_reserves_last_minute
  Scenario:
    When I search a plan for today
    Then I can see the new reservation
    When The last minute process runs
    Then I can see my plan cancellation

  @user_reserves_last_minute_late
  Scenario:
    When I search a plan for today late
    Then I can see I can't search last minute diinners
