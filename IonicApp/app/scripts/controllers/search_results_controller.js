"use strict";

dinnerApp.controller('SearchResultsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'SharedService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $sharedService
    ) {

      $scope.reservationList = $sharedService.get().reservationList;

      selectReservationFromSlide($sharedService.get().selectedSlide || 0);

      function selectReservationFromSlide(index){
        $scope.activeSlide = index;
        $scope.reservationSelected = $scope.reservationList[index].reservation;
        $sharedService.set({
          reservationSelected: $scope.reservationSelected,
          selectedSlide: index
        });
      }

      $scope.slideChanged = function(index){
        selectReservationFromSlide(index);
      };

      $scope.reserve = function(index){
        $state.go('payment');
      };
}]);
