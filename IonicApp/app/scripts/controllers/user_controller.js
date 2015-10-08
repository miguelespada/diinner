"use strict";

dinnerApp.controller('UserCtrl',
  [ '$scope',
    '$state',
    'InitService',
    'SharedService',
    function(
      $scope,
      $state,
      $initService,
      $sharedService
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
        $initService.initUser($scope.user);
        $sharedService.set({
          requireInitUser: false
        })
      }

      $scope.openNotifications = function(){
        $state.go('notifications');
      };

      if($scope.user.first_login){
        $state.go('first_login');
      }

}]);
