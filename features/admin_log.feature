@admin_logs
Feature: Admin Log
  As admin
  In order to monitor the activity on the web
  I would like to have a log

  Background:
    Given I am logged as admin

  @admin_new_user_log
  Scenario: 
    When a new user is registered 
    Then I should see the log of the creation of the new user
    And I can access to the new user the data

  @admin_new_restaurant_log
  Scenario: 
    When a new restaurant is created 
    Then I should see the log of the creation of the new restaurant
    And I can access to the new restaurant the data


  @admin_new_test_response_log
  Scenario: 
    When a user answers a test 
    Then I should see the log of the creation of the new test response
    And I can access to the test response data

  @admin_new_test_response_log
  Scenario: 
    When a restaurant has created a table
    Then I should see the log of the creation of the new table
    # TODO And I can access to the table data