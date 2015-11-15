"use strict";

dinnerApp.controller('NewReservationCtrl',
  [
    'SharedService',
    function(
             $sharedService
    ) {
      $sharedService.set({
        back: {
          hasBackAction: false
        },
        search: {
          formType: 'newReservation'
        }
      });
}]);
