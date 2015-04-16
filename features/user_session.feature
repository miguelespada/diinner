Feature: User Session
  As user
  I want to access to my personal space

  @login_user
  Scenario: I can see the login page
    Given I am guest
    When I go to the user page
    Then I should see the user login panel

  @logged_user
  Scenario: I am logged as user and have user data
    Given I am a user
    When I go to the user page
    Then I should have user data
