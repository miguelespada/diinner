"use strict";

dinnerApp.controller('MainCtrl',
  [
    '$scope',
    '$state',
    function($scope,
             $state) {

      $state.go('user');

}]);
