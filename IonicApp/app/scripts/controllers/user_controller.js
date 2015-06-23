"use strict";

dinnerApp.controller('UserCtrl', ['$scope', 'UserManager', function($scope, $userManager) {
  $scope.user = $userManager.getUser();
}]);
