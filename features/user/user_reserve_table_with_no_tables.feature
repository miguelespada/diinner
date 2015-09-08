Feature: User reserves table with no tables
  As user
  I want to be informed when there are no tables

  Background:
    Given I am a logged user
    And There are some available tables

  @user_reserves_table_with_no_tables
  Scenario: User reserve a table with error
    When I search a table with no matchs
    When I should be notified that there are no tables matching by criteria