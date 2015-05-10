Feature: Restaurant autorization
  As restaurant
  I am not allowed to edit other restaurant data

  Background:
    Given I am logged as restaurant
    When I visit other restaurant data

  @restaurant_edit_autorization
  Scenario:
    Then I do not see the edit link

  @restaurant_edit_autorization
  Scenario:
    When I try to edit the other restaurant data
    Then I receive an unauthorized exception