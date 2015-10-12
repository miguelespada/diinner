"use strict";

dinnerApp.controller('LoginCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'LoadingService',
    'auth',
    function($scope,
             $state,
             $userManager,
             $loadingService,
             auth
    ) {

      if(window.localStorage.getItem("user")){
        $state.go('user');
      }

      $scope.login = function (connection) {
        $loadingService.loading(true);
        auth.signin({
          popup: true,
          popupOptions: { clearcache: true, clearsessioncache: true },
          connection: connection,
          loginAfterSignup: false,
          rememberLastLogin: false,
          sso: false,
          authParams: {
            scope: 'openid offline_access',
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
        if (profile != null){
          window.localStorage.setItem('profile', JSON.stringify(profile));
        }
        if (token != null){
          window.localStorage.setItem('token', JSON.stringify(token));
        }
        if (refreshToken != null){

          window.localStorage.setItem('refreshToken', JSON.stringify(refreshToken));
        }
        $userManager.getUser().$promise.then(function(user) {
          if (user != null){
            window.localStorage.setItem('user', JSON.stringify(user));
            $state.go('user');
          }
          $loadingService.loading(false);
        });
      }

      function onLoginFailed() {
        $loadingService.loading(false);
      }
}]);
