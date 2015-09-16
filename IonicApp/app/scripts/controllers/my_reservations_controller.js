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
             $uiCalendarConfig) {
  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  $scope.panelShown = 'calendar-results';

  $scope.alertOnEventClick = function( date, jsEvent, view){
    $sharedService.set({reservationSelected: date.reservation});
    $state.go('reservation');
  };

  $scope.gridAction = function(index){
    $sharedService.set({reservationSelected: $scope.reservationList[index].reservation});
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

  $userManager.getReservations().$promise.then(function(reservations) {
    $scope.reservationList = reservations.reservations;
    $scope.chunkedData = $utilService.chunkInRows($scope.reservationList, 2);

    angular.forEach($scope.reservationList, function(value, key) {
      var reservation = value.reservation;

      if(!reservation.cancelled){
        var date = new Date(reservation.date);

        var newEvent = {
          title: reservation.restaurant.name,
          start: date,
          reservation: reservation,
          stick: true};

        $scope.events.push(newEvent);
        $uiCalendarConfig.calendars['myCalendar'].fullCalendar('addEventSource', newEvent);
      }
    });

  });

  $scope.changeView = function(){
    $scope.panelShown = $scope.panelShown == 'calendar-results' ? 'grid-results' : 'calendar-results';
  };



}]);
