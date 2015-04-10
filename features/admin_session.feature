Feature: Admin Session
  As admin
  I want to access to my personal space

  Scenario: I log as admin
    Given I am admin
    When I login
    Then I should see my personal space

  Scenario: I cannot access to admin page
    Given I am guest
    When I go to the admin page
    Then I should not see the admin page

  Scenario: I logout
    Given I am logged as admin
    When I logout
    Then I should see the homepage