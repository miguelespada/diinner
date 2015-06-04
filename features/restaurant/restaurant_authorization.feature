Feature: Restaurant authorization
  As restaurant
  I am not allowed to access other restaurant data

  Background:
    Given I am logged as restaurant
    And There is another restaurant

  @restaurant_authorization
  Scenario:
    Then I cannot access other restaurant data
    And I cannot access other restaurant menus
    And I cannot access other restaurant tables
    And I cannot access other restaurant reservations