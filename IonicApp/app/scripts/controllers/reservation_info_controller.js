"use strict";

dinnerApp.controller('ReservationInfoCtrl',
  [
    '$scope',
    '$state',
    'SharedService',
    function($scope,
             $state,
             $sharedService
    ) {

  $scope.openRestaurant = function(){
    $sharedService.set({
      reservations: {
        selected: $scope.reservation
      }
    });
    $state.go('restaurant');
  };

}]);
