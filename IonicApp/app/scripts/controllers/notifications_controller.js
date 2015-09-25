"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'LoadingService',
    function($scope,
             $state,
             $userManager,
             $loadingService
    ) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $loadingService.loading(true);
      $userManager.getNotifications().$promise.then(function(notifications) {
        $scope.notificationList = notifications;
        $loadingService.loading(false);
      }, $loadingService.rejectedPromise());

      $scope.getNotificationSrc = function (notificationKey) {
        return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
      };

}]);
