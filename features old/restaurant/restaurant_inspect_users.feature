@wip
Feature: Restaurant inspect users
  As restaurant
  I want to see my clients

  Background:
    Given A user has reserved a table

  @restaurant_inspect_user
  Scenario:
    When I login as restaurant
    And I access the user data through the reservation