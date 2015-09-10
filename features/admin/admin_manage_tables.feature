@admin_manage_tables
Feature: Admin Manage Tables
  As admin
  I want to delete old empty tables


  @batch_delete_tables
  Scenario: I create a restaurant
    Given I am logged as admin
    And There are some tables
    When I batch delete the tables
    Then I should not see the old tables