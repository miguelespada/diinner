"use strict";

dinnerApp.service('ModelService',
  [
    'SharedService',
    '$state',
    function(
    $sharedService,
    $state
  ){
  function loadReservation(reservation){
    $sharedService.set({
      reservations: {
        selected: reservation.reservation
      }
    });
    $state.go('reservation');
  }


  return {
    loadReservation: loadReservation
  }
}]);
