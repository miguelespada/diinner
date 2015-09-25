"use strict";

dinnerApp.controller('SearchResultsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'SharedService',
    'UtilService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $sharedService,
             $utilService
    ) {

      $scope.panelShown = "slide-results";
      $scope.reservationList = $sharedService.get().reservationList;
      $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, 2);

      $scope.changeView = function(){
        $scope.panelShown = $scope.panelShown == "slide-results" ? "grid-results" : "slide-results";
      };

      selectReservationFromSlide($sharedService.get().selectedSlide || 0);

      function selectReservationFromSlide(index){
        $scope.activeSlide = index;
        if ($scope.reservationList.length > 0){
          $scope.reservationSelected = $scope.reservationList[index].reservation;
          $sharedService.set({
            reservationSelected: $scope.reservationSelected,
            selectedSlide: index
          });
        }
      }

      $scope.slideChanged = function(index){
        selectReservationFromSlide(index);
      };

      $scope.reserve = function(index){
        $state.go('payment');
      };

      $scope.gridAction = function(index){
        $scope.changeView();
        $scope.slideChanged(index);
      };
}]);
