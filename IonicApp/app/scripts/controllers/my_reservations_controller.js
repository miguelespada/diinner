"use strict";

dinnerApp.controller('MyReservationsCtrl',
  [
    '$scope',
    '$state',
    '$ionicSlideBoxDelegate',
    'UserManager',
    'SharedService',
    'uiCalendarConfig',
    'store',
    function($scope,
             $state,
             $ionicSlideBoxDelegate,
             $userManager,
             $sharedService,
             $uiCalendarConfig,
             store) {
  $scope.user = store.get('user');

  $scope.alertOnEventClick = function( date, jsEvent, view){
    $sharedService.set({reservationSelected: date.reservation});
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

  $scope.activeSlide = 0;

  $userManager.getReservations().$promise.then(function(reservations) {
    $scope.reservationList = reservations.reservations;

    angular.forEach($scope.reservationList, function(value, key) {
      var reservation = value.reservation;
      if(!reservation.cancelled){
        var date = new Date(reservation.date);
        var time = new Date(reservation.time);
        date.setHours(time.getHours());
        date.setMinutes(time.getMinutes());
        var newEvent= {title: reservation.restaurant.name, start: date, reservation: reservation};
        $scope.events.push(newEvent);
        $uiCalendarConfig.calendars['myCalendar'].fullCalendar('addEventSource', newEvent);
      }
    });
  });



}]);
