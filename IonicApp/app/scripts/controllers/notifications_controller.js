"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    'SharedService',
    function($scope,
             $sharedService
    ) {
      $scope.user = $sharedService.get().user;
      $scope.notificationList = $sharedService.get().notifications.all;

      $scope.getNotificationSrc = function (notificationKey) {
        return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
      };

}]);
