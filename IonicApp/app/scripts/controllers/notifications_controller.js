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
      console.log($scope.notificationList);

  $scope.getNotificationSrc = function (notificationKey) {
    return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
  };

}]);
