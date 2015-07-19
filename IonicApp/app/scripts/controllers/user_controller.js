"use strict";

dinnerApp.controller('UserCtrl', ['$scope', 'UserManager', '$http', 'ENV', function($scope, $userManager, $http, ENV) {
  $scope.user = $userManager.getUser();
}]);
