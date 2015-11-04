"use strict";

dinnerApp.controller('UserCtrl',
  [ '$scope',
    '$state',
    'InitService',
    'SharedService',
    'ModelService',
    function(
      $scope,
      $state,
      $initService,
      $sharedService,
      $modelService
    ) {


      if (!$sharedService.get().loaded) {
        $scope.user = JSON.parse(window.localStorage.getItem("user"));
        $sharedService.set({
          loaded: true,
          requireInitUser: true
        })
      } else {
        $scope.user = $sharedService.get().user;
      }


      if ($sharedService.get().requireInitUser){
        $initService.initUser($scope.user,
          {
            reservations: function(response){
              $scope.todayReservation = response.reservations.hasReservations ? response.reservations.today : null;
            }
          }
        );
        $sharedService.set({
          requireInitUser: false
        })
      } else {
        $scope.todayReservation = $sharedService.get().reservations.hasReservations ? $sharedService.get().reservations.today : null;
      }


      $scope.openTodayReservation = function(){
        $modelService.loadReservation($scope.todayReservation);
      };

      $scope.openNotifications = function(){
        $state.go('notifications');
      };

      if($scope.user.first_login){
        $state.go('first_login');
      };

}]);
