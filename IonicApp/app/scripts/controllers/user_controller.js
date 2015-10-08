"use strict";

dinnerApp.controller('UserCtrl',
  [ '$scope',
    '$state',
    'InitService',
    function(
      $scope,
      $state,
      $initService
    ) {


      $scope.user = JSON.parse(window.localStorage.getItem("user"));

      if($scope.user.first_login){
        $state.go('first_login');
      }

      $initService.initUser($scope.user);

      $scope.openNotifications = function(){
        $state.go('notifications');
      };



}]);
