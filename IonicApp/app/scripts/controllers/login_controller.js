"use strict";

dinnerApp.controller('LoginCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'auth',
    'store',
    function($scope,
             $state,
             $userManager,
             auth,
             store) {

      $scope.signin = function() {
        auth.signin({
          authParams: {
            scope: 'openid',
            device: 'Mobile device'
          }
        }, function(profile, token, accessToken, state, refreshToken) {
          // Success callback
          store.set('profile', profile);
          store.set('token', token);
          store.set('refreshToken', refreshToken);
          $state.go('index');
        }, function() {
          console.log("ERROR LOGGING");
          // Error callback
        });
      }

}]);
