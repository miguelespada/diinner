Feature: Restaurant profile
  As restaurant
  I want to manage my own profile

  Background:
    Given I am logged as restaurant

  @restaurant_profile
  Scenario: I check my profile
    When I go to my profile page
    Then I should see my profile

  @restaurant_profile
  Scenario: I edit my profile
    When I edit my restaurant profile
    Then I should see my restaurant profile updated

