Feature: User profile
  As user
  I want to manage my own profile

  Background:
    Given I am a logged user

  @first_login_user
  Scenario: It is the first time i login as user
    Given Is the first time I login as user
    When I go to the user page
    Then I should see the edit profile page

  @first_login_user
  Scenario: I am logged as user for first time and i want to edit my profile
    When I go to the user page
    When I change my user profile
    Then I should see my profile updated

  @user_profile
  Scenario: I can edit my profile
    When I change my user profile
    Then I should see my profile updated

  @user_profile
  Scenario: I check my profile
    When I go to the user page
    Then I should see my user profile