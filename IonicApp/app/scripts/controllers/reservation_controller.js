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


  $scope.user = $sharedService.get().user;
  $scope.reservation = $sharedService.get().reservations.selected;

  $scope.cancel = function(){
    $userManager.cancelReservation($scope.reservation.id); //TODO update reservations
    $state.go('user');
  };

  $scope.openRestaurant = function(){
    $state.go('restaurant');
  };

}]);
