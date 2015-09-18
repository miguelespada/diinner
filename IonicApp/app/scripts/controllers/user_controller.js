"use strict";

dinnerApp.controller('UserCtrl',
    function($scope,
             $state) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));

      if($scope.user.first_login){
        $state.go('first_login');
      }
});
