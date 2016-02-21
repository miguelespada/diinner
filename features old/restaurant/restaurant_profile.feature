@restaurant_profile
Feature: Restaurant profile
  As restaurant
  I want to manage my own profile

  Background:
    Given I am logged as restaurant

  @restaurant_check_profile
  Scenario: I check my profile
    When I go to my profile page
    Then I should see my profile
    And I should see that a suggestion to change my password

  Scenario: I edit my profile
    When I edit my restaurant profile
    Then I should see my restaurant profile updated

  @restaurant_change_password
  Scenario:
    When I change my restaurant password
    Then I should check my password has changed