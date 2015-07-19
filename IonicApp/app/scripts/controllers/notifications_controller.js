"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    function($scope,
             $state,
             $userManager,
             $sharedService) {

  $scope.user = $userManager.getUser();
  $scope.notificationList = $userManager.getNotifications();

}]);
