"use strict";

dinnerApp.controller('NotificationsCtrl',
  [
    '$scope',
    'SharedService',
    'UserManager',
    'ModelService',
    function($scope,
             $sharedService,
             $userManager,
             $modelService
    ) {
      $sharedService.set({
        back: {
          hasBackAction: false
        }
      });
      $scope.user = $sharedService.get().user;

      $userManager.readNotifications().$promise.then(function(user) {
        if(user != null){
          window.localStorage.setItem('user', JSON.stringify(user));
          $sharedService.set({user: user});
        }
      });
      $scope.notificationList = $sharedService.get().notifications.all;

      console.log($scope.notificationList);


      $scope.getNotificationSrc = function (notificationKey) {
        return 'templates/notifications/' + notificationKey.replace(".","_") + '.html';
      };

      $scope.openNotification = function (notification) {
        var notification_id = notification.trackable.id;
        var reservations = $sharedService.get().reservations.all;
        var reservationSelected = reservations.find(function(element, index, array){
          return element.reservation.id == notification_id;
        });
        $modelService.loadReservation(reservationSelected);
      };

}]);
