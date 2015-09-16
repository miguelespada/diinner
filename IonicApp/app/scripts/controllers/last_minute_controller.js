"use strict";

dinnerApp.controller('LastMinuteCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'TableManager',
    'SharedService',
    'UtilService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $tableManager,
             $sharedService,
             $utilService
             ) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  $scope.panelShown = "grid-results";

  $scope.activeSlide = 0;


  $tableManager.searchLastMinute().$promise.then(function(reservations) {
    $scope.reservationList = reservations.reservations;
    $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, 2);
  });

  $scope.gridAction = function(index){
    $scope.activeSlide = index;
    $scope.panelShown = "slide-results";
    $ionicSlideBoxDelegate.update();
  };

  $scope.reserve = function(index){
    $scope.reservationSelected = $scope.reservationList[index].reservation;
    $sharedService.set({reservationSelected: $scope.reservationSelected});
    $state.go('payment');
  };
}]);
