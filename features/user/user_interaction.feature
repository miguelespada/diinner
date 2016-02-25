@user_interaction @javascript
Feature: User Interaction
  As user
  I want to interact with the website

  Background:
    Given I am a logged user
    And There are some available tables for tomorrow

  @user_back_search
  Scenario: I can go back when searching
    When I search a table with default values
    And I go back
    Then I can see I'm at the search form

  @user_back_payment
  Scenario: I can go back when paying
    When I search a table and go to payment
    And I go back
    Then I can see I'm at the search form
