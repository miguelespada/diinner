"use strict";

dinnerApp.controller('PaymentCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    function($scope,
             $state,
             $userManager,
             $sharedService) {

  $scope.user = $userManager.getUser();

  $scope.reservationSelected = $sharedService.get().reservationSelected;

  console.log($scope.reservationSelected);
}]);
