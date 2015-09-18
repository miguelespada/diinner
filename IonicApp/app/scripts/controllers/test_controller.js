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

      $loadingService.loading(true);
      $userManager.getTest().$promise.then(function(response) {
        $scope.response = response;
        $loadingService.loading(false);
        if(!response.has_test){
          $state.go('profile');
        }
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
