"use strict";

dinnerApp.controller('NewReservationCtrl',
  [
    'SharedService',
    function(
             $sharedService
    ) {
      $sharedService.set({searchFormType: 'newReservation'});
}]);
