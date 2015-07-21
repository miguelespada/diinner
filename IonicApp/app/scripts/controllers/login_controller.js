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

      $scope.login = function (connection) {
        $scope.loading = true;
        auth.signin({
          popup: true,
          connection: connection,
          authParams: {
            scope: 'openid',
            device: 'Mobile device'
          }
        }, onLoginSuccess, onLoginFailed);

      };

      $scope.loginWithGoogle = function(){
        $scope.login('google-oauth2');
      };

      $scope.loginWithFacebook = function(){
        $scope.login('facebook');
      };


      function onLoginSuccess(profile, token, accessToken, state, refreshToken) {
        // Success callback
        store.set('profile', profile);
        store.set('token', token);
        store.set('refreshToken', refreshToken);
        $state.go('user');
        $scope.loading = false;
      }

      function onLoginFailed() {
        $scope.loading = false;
      }

}]);
