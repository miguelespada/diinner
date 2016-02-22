@site_protected
Feature: Site Protected
  As user
  I want to access to my personal space
  The site is protected

  @blocked_first_login_user
  Scenario: I am logged as user for the first time and the access is blocked
    Given I am a first login user
    And The site is protected
    When I go to the user page
    Then I should see the protected page

  @blocked_returning_user
  Scenario: I am logged as user with user data and the access is blocked
    Given I am a logged user
    And The site is protected
    When I go to the user page
    Then I should see the user page
