"use strict";

dinnerApp.controller('MyReservationsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'UserManager',
    'SharedService',
    'UtilService',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $userManager,
             $sharedService,
             $utilService
    ) {
      $scope.user = $sharedService.get().user;
      $scope.panelShown = 'grid-results';
      $scope.hasTodayReservation = $sharedService.get().reservations.today != false;

      $scope.loadTodayReservation = function(){
        loadReservation($sharedService.get().reservations.today);
      };

      $scope.alertOnEventClick = function( date, jsEvent, view){
        loadReservation(date);
      };

      $scope.gridAction = function(index){
        loadReservation($scope.reservationList[index]);
      };

      function loadReservation(reservation){
        $sharedService.set({
          reservations: {
            selected: reservation.reservation
          }
        });
        $state.go('reservation');
      }

      $scope.uiConfig = {
        calendar:{
          height: 450,
          header:{
            right: 'today prev,next'
          },
          eventClick: $scope.alertOnEventClick
        }
      };
      $scope.events = [];
      $scope.eventSources = [$scope.events];

      if ($sharedService.get().reservations.hasReservations) {
        $scope.reservationList = $sharedService.get().reservations.all;
        $scope.cols = 1;
        $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, $scope.cols);

        angular.forEach($scope.reservationList, function (value, key) {
          var reservation = value.reservation;

          if (!reservation.cancelled) {
            var date = new Date(reservation.date);

            var newEvent = {
              title: reservation.restaurant.name,
              start: date,
              reservation: reservation,
              stick: true
            };

            $scope.events.push(newEvent);
            angular.element($('#calendar-container')).fullCalendar('addEventSource', newEvent);
          }
        });
      }

      $scope.changeView = function(){
        $scope.panelShown = $scope.panelShown == 'calendar-results' ? 'grid-results' : 'calendar-results';
      };

}]);
