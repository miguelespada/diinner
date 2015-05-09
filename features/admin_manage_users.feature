Feature: Admin Manage Users
  As admin
  I want to manage users

  Background:
    Given I am logged as admin
    Given There are some users

  @admin_edit_user
  Scenario: I edit a user
    When I edit a user
    Then I should see the updated user in the list of users