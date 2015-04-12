Feature: Admin Dashboard
  As an admin
  I should have access to all the controls in my dashboard

  Background:
    Given I am logged as admin

  @admin_dashboard 
  Scenario: 
    When I go to my dashboard
    Then I should see all the navigation controls
