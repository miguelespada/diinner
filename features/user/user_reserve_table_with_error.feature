Feature: User reserves table with error
  As user
  I want to access to reserve a table

  Background:
    Given There are some available tables
    And I am a logged user

  @user_reserves_table_with_error
  Scenario: User reserve a table with error
    When I try to reserve a table
    And Stripe cannot create the customer information
    Then I shoud not see the reservation in my reservations