"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    'SharedService',
    'UserManager',
    function($scope,
             $sharedService,
             $userManager
    ) {
      $scope.user = $sharedService.get().user;

      $userManager.readNotifications();
      $scope.notificationList = $sharedService.get().notifications.all;

      $scope.getNotificationSrc = function (notificationKey) {
        return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
      };

}]);
