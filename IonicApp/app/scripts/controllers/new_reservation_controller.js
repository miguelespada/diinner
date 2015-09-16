"use strict";

dinnerApp.controller('NewReservationCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'CityManager',
    'TableManager',
    'SharedService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $cityManager,
             $tableManager,
             $sharedService
             ) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));
  $scope.cityList = $cityManager.getCities();

  $scope.friendsList = [
    { text: "Solo", value: 0 },
    { text: "+1", value: 1 },
    { text: "+2", value: 2 }
  ];

  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.ageList = [18,19,20]; //TODO

  $scope.expectationList = [
    { text: "Diinner and bed", value: 1 },
    { text: "Diinner and party", value: 2 }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.panelShown = "search-form";

  $scope.filters = {
    price: $scope.user.preference.menu_price,
    city: $scope.user.preference.city_id,
    companies_attributes: []
  };

  $scope.activeSlide = 0;

  $scope.searchReservations = function(filters){
    $tableManager.searchTables(filters).$promise.then(function(reservations) {
      $scope.reservationList = reservations.reservations;
      $ionicSlideBoxDelegate.update();
    });
    $scope.panelShown = "slide-results";
    $ionicSlideBoxDelegate.update();
  };

  $scope.reserve = function(index){
    $scope.reservationSelected = $scope.reservationList[index].reservation;
    $sharedService.set({reservationSelected: $scope.reservationSelected});
    $state.go('payment');
  };
}]);
