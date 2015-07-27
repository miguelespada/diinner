"use strict";

dinnerApp.controller('UserCtrl',
  [
    '$scope',
    'UserManager',
    'store',
    function($scope,
             $userManager,
             store) {
      $scope.user = store.get('user');
}]);
