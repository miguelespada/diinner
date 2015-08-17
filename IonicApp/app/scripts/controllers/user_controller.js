"use strict";

dinnerApp.controller('UserCtrl',
  [
    '$scope',
    'UserManager',
    function($scope,
             $userManager) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));
}]);
