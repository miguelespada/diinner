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

      $scope.searchFormType = $sharedService.get().searchFormType;

      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $loadingService.loading(true);
      $cityManager.getCities().$promise.then(function(response) {
        $scope.cityList = response.cities;
        $loadingService.loading(false);
      }, $loadingService.rejectedPromise());

      $scope.dateList = [
        { text: "Tomorrow", value: 'tomorrow' },
        { text: "Later", value: 'other' }
      ];

      $scope.friendsList = [
        { text: "0", value: 0 },
        { text: "1", value: 1 },
        { text: "2", value: 2 }
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
        { text: "Bed", value: 1 },
        { text: "Party", value: 2 }
      ];

      $scope.priceList = [ 20, 40, 60 ];

      $scope.filters = {
        price: $scope.user.preference.menu_price || 20,
        city: $scope.user.preference.city_id || $scope.cityList[0].id,
        companies_attributes: [],
        selectedDate: "tomorrow",
        friends: 0
      };

      $scope.searchReservations = function(filters){
        $sharedService.set({
          selectedSlide: 0
        });

        console.log($sharedService.get());
        if (filters.selectedDate != 'other'){
          filters.date = $utilService.dateToString($utilService.dateValue(filters.selectedDate));
        }

        if($utilService.stringToDate(filters.date).getTime() > new Date().getTime()){
          $loadingService.loading(true);
          if($scope.searchFormType == "lastMinute"){
            $tableManager.searchLastMinute(filters).$promise.then(handleReservationResults, $loadingService.rejectedPromise());
          } else {
            $tableManager.searchTables(filters).$promise.then(handleReservationResults, $loadingService.rejectedPromise());
          }
        }
      };

      function handleReservationResults(reservations){
        $sharedService.set({reservationList: reservations.reservations});
        $loadingService.loading(false);
        $state.go('search_results');
      }

}]);
