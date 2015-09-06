Feature: User reserves last minute diinner
  As user
  I want to access to reserve a table for today

  Background:
    And I am a logged user

  @user_reserves_a_last_minute_diinner_pending
  Scenario:
    Given There are some last minute diinners
    And I have preferences
    When I reserve a last minute diinner
    Then I shoud be notified that my plan is pending
    And I can access to the pending reservation through my reservations
    And I cannot cancel the reservation

  @user_closes_a_last_minute_diinner
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation
    And I have preferences
    When I reserve a last minute diinner
    Then I should be notified that my last minute plan is confirmed
    And I can access to the confirmed reservation through my reservations
    And I cannot cancel the reservation
    And The other user can see the confirmed last minute reservation
    And The restaurant should be see the confirmed last minute reservation
    And The admin should see the confirmed last minute reservation
  
  @user_closes_a_last_minute_diinner_with_error_in_the_other_reservation
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation with error
    And I have preferences
    When I reserve a last minute diinner
    And I can access to the pending reservation through my reservations
    And The other user can see the cancelled last minute reservation

  @user_closes_a_last_minute_diinner_with_error_in_my_reservation
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation
    And I have preferences
    When I reserve a last minute diinner with error
    Then I should be notified that my last minute plan is cancelled
    And The other user can see the pending last minute reservation