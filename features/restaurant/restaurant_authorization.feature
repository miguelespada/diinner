Feature: Restaurant authorization
  As restaurant
  I am not allowed to edit other restaurant data

  Background:
    Given I am logged as restaurant
    When I visit other restaurant data

  @restaurant_edit_authorization
  Scenario:
    Then I do not see the edit link

  @restaurant_edit_authorization
  Scenario:
    When I try to edit the other restaurant data
    Then I receive an unauthorized exception

  @restaurant_menu_authorization
  Scenario:
    Then I cannot access other restaurant menu

  @restaurant_table_authorization
  Scenario:
    Then I cannot access other restaurant table

  @restaurant_reservation_authorization
  Scenario:
    Then I cannot access other restaurant reservations