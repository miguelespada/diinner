Feature: Admin Manage Restaurants
  As admin
  In order to create user profile
  I want to manage A/B tests

  Background:
    Given I am logged as admin
    When I create a new test

  @create_test
  Scenario: I create a new test
    Then I should see the test in list of tests

  @preview_test
  Scenario: I preview a new test
    Then I can preview the test

  @edit_test  
  Scenario: I edit a test
    When I edit a test
    Then I should see the updated test in the list of tests

  @delete_test
  Scenario: I delete a test
    When I delete a test
    Then I should not see the test in the list of tests