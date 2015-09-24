"use strict";

dinnerApp.controller('SearchFormCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'CityManager',
    'TableManager',
    'SharedService',
    'LoadingService',
    'UtilService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $cityManager,
             $tableManager,
             $sharedService,
             $loadingService,
             $utilService
    ) {

      $scope.selectedDate = "today";

      $scope.searchFormType = $sharedService.get().searchFormType;

      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $loadingService.loading(true);
      $cityManager.getCities().$promise.then(function(response) {
        $scope.cityList = response.cities;
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

      $scope.ageList = [];
      for (var i = 18; i < 65; i++){
        $scope.ageList.push(i);
      }

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
        if ($scope.selectedDate != 'other'){
          filters.date = $utilService.dateToString($utilService.dateValue($scope.selectedDate));
        }

        $loadingService.loading(true);
        if($scope.searchFormType == "lastMinute"){
          $tableManager.searchLastMinute(filters).$promise.then(handleReservationResults);
        } else {
          $tableManager.searchTables(filters).$promise.then(handleReservationResults);
        }

      };

      function handleReservationResults(reservations){
        $sharedService.set({reservationList: reservations.reservations});
        $loadingService.loading(false);
        $state.go('search_results');
      }

}]);
