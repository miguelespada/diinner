"use strict";

dinnerApp.controller('ReservationCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'store',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             store) {


  $scope.user = store.get('user');

  $scope.reservation = $sharedService.get().reservationSelected;

  $scope.cancel = function(){
    $userManager.cancelReservation($scope.reservation.id);
    $state.go('user');
  };

}]);
