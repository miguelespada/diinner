"use strict";

dinnerApp.controller('ProfileCtrl',
  [
    '$scope',
    '$state',
    'auth',
    '$cordovaSocialSharing',
    '$ionicHistory',
    'InitService',
    function(
      $scope,
      $state,
      auth,
      $cordovaSocialSharing,
      $ionicHistory,
      $initService
    ) {

  $scope.logout = function() {
    auth.signout();
    window.localStorage.removeItem("profile");
    window.localStorage.removeItem("token");
    window.localStorage.removeItem("user");
    window.localStorage.removeItem("refreshToken");
    $ionicHistory.clearCache();
    $ionicHistory.clearHistory();
    $initService.clear();
    $state.go('index');
  };

  $scope.shareAnywhere = function() {
    $cordovaSocialSharing.share("Mensaje de prueba", "Asunto de prueba", "www/images/ionic.png", "http://diinner.com");
  }
}]);
