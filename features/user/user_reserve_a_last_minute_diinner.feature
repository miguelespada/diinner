@last_minute
Feature: User reserves last minute diinner
  As user
  I want to access to reserve a table for today

  Background:
    And I am a logged user
    And I have preferences

  @user_reserves_a_last_minute_dinner_and_there_are_no_dinners
  Scenario:
    Given There are no last minute diinners
    Then I should be notified that there are no last minute dinners

  @user_cannot_reserve_dinners_off_the_clock
  Scenario:
    Given There are some last minute diinners
    And it is off the clock
    Then I should be notified that I cannot reserve dinners

  @user_reserves_a_last_minute_diinner_pending
  Scenario:
    Given There are some last minute diinners
    When I reserve a last minute diinner
    Then I shoud be notified that my plan is pending
    And I can access to the pending reservation through my reservations
    And I cannot cancel the reservation
    And I cannot reserve again for the same date

  @user_closes_a_last_minute_diinner
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation
   When I reserve a last minute diinner
   Then I should be notified that my last minute plan is confirmed
   And I can access to the confirmed reservation through my reservations
   And I cannot cancel the reservation
   And The other user can see the confirmed last minute reservation
   And The restaurant should be see the confirmed last minute reservation
   And The restaurant should be notified of last minute reservation
   And The admin should see the confirmed last minute reservation
  
  @user_closes_a_last_minute_diinner_with_error_in_the_other_reservation
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation with error
   When I reserve a last minute diinner
   And I can access to the pending reservation through my reservations
   And The other user can see the cancelled last minute reservation

  @user_closes_a_last_minute_diinner_with_error_in_my_reservation
  Scenario:
    Given There are some last minute diinners
    Given They have been a reservation
   When I reserve a last minute diinner with error
   Then I should be notified that my last minute plan is cancelled
   And The other user can see the pending last minute reservation

  @user_reserves_a_last_minute_diinner_and_it_is_cancel_at_six
  Scenario:
    Given There are some last minute diinners
   When I reserve a last minute diinner
   Then I shoud be notified that my plan is pending
   When Last minute tables are processed at six
   Then I should see that my last minute plan is cancelled