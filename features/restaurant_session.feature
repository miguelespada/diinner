Feature: Restaurant Session
  As restaurant
  I want to access to my personal space

  @login_restaurant
  Scenario: I log as restaurant
    Given I am a restaurant
    When I login as restaurant
    Then I should see my personal restaurant space

  @restaurant_session
  Scenario: I cannot access to restaurant page
    Given I am guest
    When I go to the restaurant page
    Then I should not see the restaurant page
    
  @restaurant_session
  Scenario: I logout
    Given I am logged as restaurant
    When I logout
    Then I should see the homepage
