"use strict";

dinnerApp.controller('FirstLoginTestCtrl',
  [
    '$scope',
    '$state',
    function(
      $scope,
      $state
    ) {

  $scope.skip = function(){
        $state.go('user');
  };

  $scope.doTest = function(){
    $state.go('test');
  };

}]);
