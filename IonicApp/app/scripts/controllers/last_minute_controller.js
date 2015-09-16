"use strict";

dinnerApp.controller('LastMinuteCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'TableManager',
    'SharedService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $tableManager,
             $sharedService
             ) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  $scope.panelShown = "grid-results";

  $scope.activeSlide = 0;

  function chunk(arr, size) {
    var newArr = [];
    for (var i=0; i<arr.length; i+=size) {
      newArr.push(arr.slice(i, i+size));
    }
    return newArr;
  }

  $tableManager.searchLastMinute().$promise.then(function(reservations) {
    $scope.reservationList = reservations.reservations;
    $scope.chunkedData = chunk($scope.reservationList, 2);
  });

  $scope.showSlide = function(index){
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
