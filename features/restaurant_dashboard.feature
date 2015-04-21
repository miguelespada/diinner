Feature: Restaurant Dashboard
  As an restaurant
  I should have access to all the controls in my dashboard

  Background:
    Given I am logged as restaurant

  @restaurant_dashboard 
  Scenario: 
    When I go to restaurant dashboard
    Then I should see all the restaurant navigation controls
