Feature: Hello diinner
  As guest
  I want to see the diinner landing page
  I order to discover diinner

  Scenario: I visit the diinner landing page
    Given I am guest
    When I visit the homepage
    Then I should see Hello World