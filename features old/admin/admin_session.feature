@admin_session
Feature: Admin Session
  As admin
  I want to access to my personal space
  
  @admin_login
  Scenario: I log as admin
    Given I am admin
    When I login as admin
    Then I should see my personal admin space


  Scenario: I cannot access to admin page
    Given I am guest
    When I go to the admin page
    Then I should not see the admin page


  @admin_logout
  Scenario: I logout
    Given I am logged as admin
    When I logout as admin
    Then I should see the homepage

  @admin_after_user_session
  Scenario: I login after a user
    Given I am a logged user
    When I go to the user page  
    When I logout
    Then I am logged as admin
    Then I should see my personal admin space

  @admin_change_password
  Scenario:
    Given I am admin
    When I login as admin
    When I change my admin password
    Then I should see that my admin password has changed