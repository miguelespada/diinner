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

      $scope.searchFormType = $sharedService.get().search.formType;

      $scope.user = $sharedService.get().user;
      $scope.cityList = $sharedService.get().default.cityList;
      $scope.dateList = $sharedService.get().default.dateList;
      $scope.friendsList = $sharedService.get().default.friendsList;
      $scope.genderList = $sharedService.get().default.genderList;
      $scope.ageList = $sharedService.get().default.ageList;
      $scope.expectationList = $sharedService.get().default.expectationList;
      $scope.priceList = $sharedService.get().default.priceList;

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

        if (filters.selectedDate != 'other'){
          filters.date = $utilService.dateToString($utilService.dateValue(filters.selectedDate));
        }

        if($utilService.stringToDate(filters.date).getTime() > new Date().getTime()){
          $loadingService.loading(true);
          if($scope.searchFormType == "lastMinute"){
            $tableManager.searchLastMinute(filters).$promise.then(handleReservationResults);
          } else {
            $tableManager.searchTables(filters).$promise.then(handleReservationResults);
          }
        }
      };

      function handleReservationResults(response){
        $sharedService.set({
          reservations: {
            results: response.reservations
          }
        });
        $loadingService.loading(false);
        $state.go('search_results');
      }

}]);
