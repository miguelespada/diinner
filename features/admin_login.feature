Feature: Admin Login
  As admin
  I want to access to my personal space

  Scenario: I log as admin
    Given I am admin
    When I login
    Then I should see my personal space