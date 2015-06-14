Feature: User reserves last minute diinner
  As user
  I want to access to reserve a table for today

  Background:
    Given There are some last minute diinners
    And I am a logged user

  @user_reserves_a_last_minute_diinner
  Scenario:
    When I reserve a last minute diinner
    And Another user reserves a last minute diinner
    Then I shoud be notified that my plan is confirmed