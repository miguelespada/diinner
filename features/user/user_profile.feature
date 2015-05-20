Feature: User profile
  As user
  I want to manage my own profile

  @first_time_login_user
  Scenario: It is the first time i login as user
    Given Is the first time I login as user
    When I change my user profile
    Then I should see my profile updated

  @edit_user_profile
  Scenario: I can edit my profile
    Given I am a logged user
    When I edit my profile
    Then I should see my profile updated
