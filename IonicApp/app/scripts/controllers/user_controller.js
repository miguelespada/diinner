"use strict";

dinnerApp.controller('UserCtrl', ['$scope', 'UserManager', '$http', 'ENV', "$ionicNavBarDelegate", function($scope, $userManager, $http, ENV, $ionicNavBarDelegate) {
  $scope.user = $userManager.getUser();
  $ionicNavBarDelegate.showBackButton(false);
}]);
