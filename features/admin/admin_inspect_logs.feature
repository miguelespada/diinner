@wip @admin_inspect_logs
Feature: Admin Log
  As admin
  In order to monitor the activity on the web
  I would like to have a log

  Background:
    Given I am logged as admin

  @admin_inspect_new_user_log
  Scenario:
    When a new user is registered
    Then I should see the log of the creation of the new user
    And I can access to the new user the data

  @admin_inspect_new_restaurant_log
  Scenario:
    When a new restaurant is created
    Then I should see the log of the creation of the new restaurant
    And I can access to the new restaurant the data

  @admin_inspect_new_test_response_log
  Scenario:
    When a user answers a test
    Then I should see the log of the creation of the new test response
    And I can access to the test response data

  @admin_inspect_new_table_log
  Scenario:
    When a restaurant has created a table
    Then I should see the log of the creation of the new table
    And I can access to the table data

  @admin_inspect_new_menu_log
  Scenario:
    When a restaurant has created a menu
    Then I should see the log of the creation of the new menu
    And I can access to the menu data