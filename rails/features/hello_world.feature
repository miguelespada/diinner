Feature: Hello world
  As guest
  I want to see the diinner landing page

  Scenario: I visit the diinner landing page
    Given I am guest
    When I visit the homepage
    Then I should see Hello World