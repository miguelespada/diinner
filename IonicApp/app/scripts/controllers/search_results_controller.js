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
      $scope.reservationList = $sharedService.get().reservations.results;

      checkReservationErrors();
      function checkReservationErrors(){
        var rError = $sharedService.get().reservations.error;
        $scope.reservationError = {
          hasError: false,
          errorMessage: ''
        };
        if ($scope.reservationList.length == 0 || rError != 'none'){
          $scope.reservationError.hasError = true;
          switch(rError){
            case 'none':
              $scope.reservationError.errorMessage = 'No results found';
              break;
            case 'reserved_date':
              $scope.reservationError.errorMessage = 'You already have a reservation for this date';
              break;
            case 'wrong_date':
              $scope.reservationError.errorMessage = 'You can only reserve Diinners from tomorrow within two weeks';
              break;
            default:
              $scope.reservationError.errorMessage = 'An error has occurred';
          }
        }
      }

      $scope.cols = 2;
      $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, $scope.cols);

      $scope.changeView = function(){
        $scope.panelShown = $scope.panelShown == "slide-results" ? "grid-results" : "slide-results";
      };

      selectReservationFromSlide($sharedService.get().selectedSlide || 0);

      function selectReservationFromSlide(index){
        $scope.activeSlide = index;
        if ($scope.reservationList.length > 0){
          $scope.reservationSelected = $scope.reservationList[index].reservation;
          $sharedService.set({
            reservations: {
              selected: $scope.reservationSelected
            },
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
