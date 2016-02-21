Feature: Admin see restaurants in a map
  As admin
  I want to restaurants in a map

  Background:
    Given There are some restaurants
    When I am logged as admin

  @inspect_map
  Scenario:
    Then I should see the restaurants on a map