Feature: User reserves last minute diinner
  As user
  I want to access to reserve a table for today

  Background:
    And I am a logged user

  @user_reserves_a_last_minute_diinner_with_error
  Scenario:
    Given I do not have prefences
    When I try to reserve a last minute diinner
    Then I should be notified that I have to fill my preferences

  @user_reserves_a_last_minute_diinner_pending @wip
  Scenario:
    Given There are some last minute diinners
    And I have prefences
    When I reserve a last minute diinner
    Then I shoud be notified that my plan is pending