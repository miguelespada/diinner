"use strict";

dinnerApp.controller('ProfileCtrl',
  [
    '$scope',
    '$state',
    'auth',
    'store',
    function(
      $scope,
      $state,
      auth,
      store
    ) {

  $scope.logout = function() {
    auth.signout();
    store.remove('profile');
    store.remove('token');
    $state.go('index');
  };
}]);
