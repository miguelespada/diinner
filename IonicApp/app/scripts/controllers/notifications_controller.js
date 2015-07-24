"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'store',
    function($scope,
             $state,
             $userManager,
             store) {

  $scope.user = store.get('user');
  $scope.notificationList = $userManager.getNotifications();

}]);
