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
      if (!$scope.user) {
        $scope.user = $userManager.getUser();
        store.set('user', $scope.user);
      }
}]);
