Feature: Restaurant profile
  As restaurant
  I want to manage my own profile

  Background:
    Given I am logged as restaurant

  @restaurant_profile  
  Scenario: I check my profile
    When I go to my profile page
    Then I should see my profile
