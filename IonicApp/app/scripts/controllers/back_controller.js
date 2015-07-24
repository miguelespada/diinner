"use strict";

dinnerApp.controller('BackCtrl',
  [
    '$scope',
    '$state',
    '$ionicPlatform',
    function($scope,
             $state,
             $ionicPlatform) {

      $scope.goBackAction = function(){

        if($state.is('profile'))
        {
          $state.go('user');
        }
        if($state.is('notifications'))
        {
          $state.go('user');
        }
        if($state.is('preferences'))
        {
          $state.go('profile');
        }
        if($state.is('new_reservation'))
        {
          $state.go('user');
        }
        if($state.is('payment'))
        {
          $state.go('new_reservation');
        }
        if($state.is('my_reservations'))
        {
          $state.go('user');
        }
        if($state.is('reservation'))
        {
          $state.go('my_reservations');
        }
      };

      $ionicPlatform.onHardwareBackButton($scope.goBackAction);
}]);
