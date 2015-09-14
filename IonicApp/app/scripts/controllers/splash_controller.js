"use strict";

dinnerApp.controller('SplashCtrl',
  [
    '$scope',
    '$state',
    function($scope,
             $state) {

      if(window.localStorage.getItem("user")){
        $state.go('user');
      } else {
        $state.go('login');
      }

}]);
