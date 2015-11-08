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

  var shareSubject = 'Diinner, cenar para quedar';
  var shareMessage = 'Entra a Diinner y conoce a alguien interesante. ¡Nosotros te organizamos la cena!';
  var shareImage = 'http://diinner.herokuapp.com/assets/favicon-19fdc6c8030891813b94848079c31838.png';
  var shareLink = 'http://diinner.herokuapp.com';
  $scope.share = function() {
    window.plugins.socialsharing.share(shareMessage, shareSubject, shareImage, shareLink);
  }
}]);
