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
      $initService.initUser($scope.user);

      if($scope.user.first_login){
        $state.go('first_login');
      }
}]);
