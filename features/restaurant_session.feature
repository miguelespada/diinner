Feature: Restaurant Session
  As restaurant
  I want to access to my personal space

  @login_restaurant
  Scenario: I log as restaurant
    Given I am a restaurant
    When I login as restaurant
    Then I should see my personal restaurant space
