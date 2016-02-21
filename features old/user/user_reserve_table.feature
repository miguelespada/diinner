

#    Scenario:
#   And I cannot reserve a table the same date

#   @user_reserves_table_bad_date
#   Scenario: 
#     When I search a table with bad date
#     And I shoud be notified that my date is out of range


#   @user_saves_default_card
#   Scenario: User saves default card
# #    Then I can see my default card on my profile #TODO PROFILE?
#     And I can reserve again with the same card

  @user_not_processed_reservation
  Scenario: User can't access not processed reservation
    When Is the reservation day
    And The reservation has not been processed
    Then I can't see the reservation