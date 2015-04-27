Feature: Admin Dashboard
  As an admin
  I would like to search users and restaurants

  Background:
    Given I am logged as admin
    And There are some users
    And There are some restaurants 
    And The elasticsearch index is syncronized
    When I do a search

  @admin_search
  Scenario: 
    Then I should see the entities matching my search
  
  @search_and_inspect_restaurant
  Scenario: 
    When I click on a restaurant
    Then I should see the restaurant details

  @search_and_inspect_user
  Scenario: 
    When I click on a user
    Then I should see the user details