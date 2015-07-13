"use strict";

dinnerApp.controller('MyReservationsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'UserManager',
    'SharedService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $userManager,
             $sharedService) {

  $scope.user = $userManager.getUser();

  $scope.activeSlide = 0;

  $userManager.getReservations().$promise.then(function(reservations) {
    $scope.reservationList = reservations.reservations;
    $ionicSlideBoxDelegate.update();
  });


  $scope.cancel = function(index){
    $scope.reservationSelected = $scope.reservationList[index].reservation;
    $userManager.cancelReservation($scope.reservationSelected.id);
    $state.go('user');
  };
}]);
