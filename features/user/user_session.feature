@user_session
Feature: User Session
  As user
  I want to access to my personal space
  I order to book diinners

  @login_user
  Scenario: I can see the login page
    Given I am guest
    When I go to the user page
    Then I should see the user login panel

  @logged_user
  Scenario: I am logged as user and have user data
    Given I am a logged user
    When I go to the user page
    Then I should see the user page

  @logout_user
  Scenario: I am logged as user and have user data
    Given I am a logged user
    When I go to the user page  
    When I logout
    Then I should see the homepage

  @first_login_user
  Scenario: I am logged as user and have user data
    Given I am a first login user
    When I go to the user page
    Then I should see the edit preferences page