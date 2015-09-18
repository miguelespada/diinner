"use strict";

dinnerApp.controller('ReservationCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    function($scope,
             $state,
             $userManager,
             $sharedService) {


  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  $scope.reservation = $sharedService.get().reservationSelected;

  $scope.cancel = function(){
    $userManager.cancelReservation($scope.reservation.id);
    $state.go('user');
  };

  $scope.openMap = function(){
    $state.go('map');
  };

}]);
