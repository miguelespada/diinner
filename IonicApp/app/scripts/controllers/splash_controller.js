"use strict";

dinnerApp.controller('SplashCtrl',
  [
    '$scope',
    '$state',
    'InitService',
    function(
      $scope,
      $state,
      $initService
    ) {

      $initService.initDefault();

      if(window.localStorage.getItem("user")){
        $state.go('user');
      } else {
        $state.go('login');
      }
}]);
