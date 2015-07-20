"use strict";

dinnerApp.controller('ReservationCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    '$ionicNavBarDelegate',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             $ionicNavBarDelegate) {

  //$ionicNavBarDelegate.showBackButton(true);

  $scope.user = $userManager.getUser();

  $scope.reservation = $sharedService.get().reservationSelected;

  $scope.cancel = function(){
    $userManager.cancelReservation($scope.reservation.id);
    $state.go('user');
  };

}]);
