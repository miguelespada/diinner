Feature: Restaurant profile
  As restaurant
  I want to manage my own profile

  @restaurant_profile
  Scenario: I check my profile
    Given I am logged as restaurant
    When I go to my profile page
    Then I should see my profile

  @restaurant_profile
  Scenario: I edit my profile
    Given I am logged as restaurant
    When I edit my restaurant profile
    Then I should see my restaurant profile updated

  @restaurant_password
  Scenario: I change my password
    Given I am logged as restaurant
    When I edit my restaurant password
    Then I should check my password has changed

  @first_password_restaurant
  Scenario: I have not changed my password and i should change it
    Given I login as restaurant with first password
    When I change my restaurant password
    Then I should check my password has changed


