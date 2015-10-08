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

      $userManager.readNotifications().$promise.then(function(user) {
        if(user != null){
          window.localStorage.setItem('user', JSON.stringify(user));
          $sharedService.set({user: user});
        }
      });;
      $scope.notificationList = $sharedService.get().notifications.all;

      $scope.getNotificationSrc = function (notificationKey) {
        return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
      };

}]);
