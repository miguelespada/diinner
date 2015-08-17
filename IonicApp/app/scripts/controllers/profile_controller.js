"use strict";

dinnerApp.controller('ProfileCtrl',
  [
    '$scope',
    '$state',
    'auth',
    '$cordovaSocialSharing',
    function(
      $scope,
      $state,
      auth,
      $cordovaSocialSharing
    ) {

  $scope.logout = function() {
    auth.signout();
    window.localStorage.removeItem("profile");
    window.localStorage.removeItem("token");
    window.localStorage.removeItem("user");
    window.localStorage.removeItem("refreshToken");
    $state.go('index');
  };

  $scope.shareAnywhere = function() {
    $cordovaSocialSharing.share("Mensaje de prueba", "Asunto de prueba", "www/images/ionic.png", "http://diinner.com");
  }
}]);
