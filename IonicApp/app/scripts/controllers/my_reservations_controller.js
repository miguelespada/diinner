"use strict";

dinnerApp.controller('MyReservationsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'UserManager',
    'SharedService',
    'UtilService',
    'uiCalendarConfig',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $userManager,
             $sharedService,
             $utilService,
             $uiCalendarConfig
    ) {
      $scope.user = $sharedService.get().user;

      $scope.panelShown = 'grid-results';

      $scope.alertOnEventClick = function( date, jsEvent, view){
        $sharedService.set({
          reservations: {
            selected: date.reservation
          }
        });
        $state.go('reservation');
      };

      $scope.gridAction = function(index){
        $sharedService.set({
          reservations: {
            selected: $scope.reservationList[index].reservation
          }
        });
        $state.go('reservation');
      };


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
        $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, 1);

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
