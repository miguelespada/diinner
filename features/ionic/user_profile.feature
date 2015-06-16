Feature: User profile

  @user_page_ionic @javascript @ionic
  Scenario:
    Given I can access to the user page
    Then I should be able to see my profile details
    And I should be able to see the user links

  @profile_page_ionic @javascript @ionic
  Scenario:
    Given I can access to the user page
    When I access to the profile page
    Then I should be able to see the profile links