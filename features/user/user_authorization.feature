Feature: User autorization
  As user
  I am not allowed to edit other user data

  Background:
    Given I am a logged user
    When I visit other user data

  @user_edit_autorization
  Scenario:
    Then I do not see the edit link

  @user_edit_autorization
  Scenario:
    When I try to edit the other user data
    Then I receive an unauthorized exception