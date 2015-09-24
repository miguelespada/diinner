"use strict";

dinnerApp.controller('NewReservationCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'CityManager',
    'TableManager',
    'SharedService',
    'LoadingService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $cityManager,
             $tableManager,
             $sharedService,
             $loadingService
    ) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $loadingService.loading(true);
      $cityManager.getCities().$promise.then(function(cities) {
        $scope.cityList = cities;
        $loadingService.loading(false);
      });

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

      $scope.filters = {
        price: $scope.user.preference.menu_price,
        city: $scope.user.preference.city_id,
        companies_attributes: []
      };

      $scope.searchReservations = function(filters){
        $loadingService.loading(true);
        $tableManager.searchTables(filters).$promise.then(function(reservations) {
          $sharedService.set({reservationList: reservations.reservations});
          $loadingService.loading(false);
          $state.go('search_results');
        });
      };

}]);
