Feature: Restaurant profile
  As restaurant
  I want to manage my own profile

  Background:
    Given I am logged as restaurant
 
  Scenario: I check my profile
    When I go to my profile page
    Then I should see my profile

  @restaurant_profile
  Scenario: I edit my profile
    When I click to edit my profile
    And I change my profile
    Then I should see my profile has been updated

