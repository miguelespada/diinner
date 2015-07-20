"use strict";

dinnerApp.controller('MainCtrl',
  [
    '$scope',
    '$state',
    '$ionicNavBarDelegate',
    function($scope,
             $state,
             $ionicNavBarDelegate) {

    //$ionicNavBarDelegate.showBackButton(false);
    $state.go('user');

}]);
