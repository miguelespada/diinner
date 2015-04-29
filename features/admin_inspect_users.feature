Feature: Admin Inspect Users
  As admin
  I want to inspect users

  Background:
    Given There are some users
    Given I am logged as admin

  @list_users
  Scenario: I list users
    Then I should see the users in the list of users