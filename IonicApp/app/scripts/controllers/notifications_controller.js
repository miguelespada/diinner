"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    '$ionicNavBarDelegate',
    function($scope,
             $state,
             $userManager,
             $ionicNavBarDelegate) {
  $ionicNavBarDelegate.showBackButton(true);
  $scope.user = $userManager.getUser();
  $scope.notificationList = $userManager.getNotifications();

}]);
