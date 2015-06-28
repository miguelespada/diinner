Feature: User reserve table

  Background:
    Given I can access to the user page

  @reserve_table_ionic @javascript @ionic
  Scenario:
    When I reserve a table in ionic
    Then I should see I have a reservation

