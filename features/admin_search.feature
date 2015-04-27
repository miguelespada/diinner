Feature: Admin Dashboard
  As an admin
  I would like to search users and restaurants

  Background:
    Given I am logged as admin
    And There are some users
    And There are some restaurants 
    And The elasticsearch index is syncronized

  @admin_search
  Scenario: 
    When I do a search
    Then I should see the entities matching my search
