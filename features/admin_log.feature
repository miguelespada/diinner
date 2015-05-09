Feature: Admin Log
  As admin
  In order to monitor the activity on the web
  I would like to have a log

  Background:
    Given I am logged as admin

  @admin_new_user_log
  Scenario: 
    When I new user is registered 
    Then I should see the log of the creation of the new user
    And I can access to the new user the data
