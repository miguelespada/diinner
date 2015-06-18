Feature: User profile

  Background:
    Given I can access to the user page

  @user_page_ionic @javascript @ionic
  Scenario:
    Then I should be able to see my profile details
    And I should be able to see the user links

  @profile_page_ionic @javascript @ionic
  Scenario:
    When I access to the profile page
    Then I should be able to see the profile links

  @preferences_page_ionic @javascript @ionic
  Scenario:
    When I access to the preferences page
    Then I should be able to see my preferences
    And I can modify my preferences