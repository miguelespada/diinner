"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    function($scope,
             $state,
             $userManager) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));
  $scope.notificationList = $userManager.getNotifications();

}]);
