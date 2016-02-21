Feature: User Reserves table
  As user
  I want to cancel a reserved a table

  Background:
    And I am a logged user
    And I have previous cancelled reservations
    And I make a reservation

  @user_cancels_reservations
  Scenario: User cancel reservation
    When I cancel my reservation
    Then I can see the notification that the reservation is cancelled
    And I should not see the reserved table