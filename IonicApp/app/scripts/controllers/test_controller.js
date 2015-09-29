"use strict";

dinnerApp.controller('TestCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'LoadingService',
    function($scope,
             $state,
             $userManager,
             $loadingService
    ) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));

      $scope.hasTest = false;

      $loadingService.loading(true);
      $userManager.getTest().$promise.then(function(response) {
        $scope.response = response;
        $scope.hasTest = response.has_test
        $loadingService.loading(false);
      });


      $scope.saveTest = function(option){
       switch(option){
         case 'A':
           $userManager.saveTest($scope.response.test.id, $scope.response.test.caption_A);
           break;
         case 'B':
           $userManager.saveTest($scope.response.test.id, $scope.response.test.caption_B);
           break;
         default:
           $userManager.saveTest($scope.response.test.id, $scope.response.test.caption_A);
       }
        $state.go('test', {}, {reload: true});
      };
}]);
