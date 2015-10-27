"use strict";

dinnerApp.controller('SearchFormCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'TableManager',
    'SharedService',
    'LoadingService',
    'UtilService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $tableManager,
             $sharedService,
             $loadingService,
             $utilService
    ) {

      $scope.isLastMinute = false;

      $scope.user = $sharedService.get().user;
      $scope.cityList = $sharedService.get().default.cityList;
      $scope.dateList = $sharedService.get().default.dateList;
      $scope.friendsList = $sharedService.get().default.friendsList;
      $scope.genderList = $sharedService.get().default.genderList;
      $scope.ageList = $sharedService.get().default.ageList;
      $scope.expectationList = $sharedService.get().default.expectationList;
      $scope.priceList = $sharedService.get().default.priceList;

      $scope.minSearchDate = $utilService.dateToString($utilService.dateValue("afterTomorrow"), true);
      $scope.maxSearchDate = $utilService.dateToString($utilService.dateValue("afterTomorrow", 13), true);

      $scope.filters = {
        price: $scope.user.preference.menu_range || 'lowcost',
        city: $scope.user.preference.city_id || $scope.cityList[0].id,
        companies_attributes: [],
        selectedDate: "tomorrow",
        friends: 0,
        otherDate: $utilService.dateValue("afterTomorrow"),
        expectation: 1
      };

      $scope.toggleChange = function() {
        $scope.isLastMinute = !$scope.isLastMinute;
        $scope.removeFriends();
      };

      $scope.removeFriends = function() {
        $scope.filters.friends = 0;
      };

      $scope.searchReservations = function(filters){
        $sharedService.set({
          selectedSlide: 0
        });

        if (filters.selectedDate != 'other'){
          filters.date = $utilService.dateValue(filters.selectedDate);
        } else {
          filters.date = filters.otherDate;
        }

        if(filters.date.getTime() > new Date().getTime()){
          filters.date = $utilService.dateToString(filters.date);
          $loadingService.loading(true);
          if($scope.isLastMinute){
            $tableManager.searchLastMinute(filters).$promise.then(handleReservationResults);
          } else {
            $tableManager.searchTables(filters).$promise.then(handleReservationResults);
          }
        }
      };

      function handleReservationResults(response){
        $sharedService.set({
          reservations: {
            results: response.reservations,
            error: response.error
          }
        });
        $loadingService.loading(false);
        $state.go('search_results');
      }

}]);
