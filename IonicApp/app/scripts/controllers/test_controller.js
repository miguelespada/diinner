"use strict";

dinnerApp.controller('TestCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             $loadingService
    ) {
      $scope.user = $sharedService.get().user;

      $scope.hasLoaded = false;
      $scope.hasTest = false;

      $loadingService.loading(true);
      $userManager.getTest().$promise.then(function(response) {
        $scope.response = response;
        $scope.hasTest = response.has_test;
        $scope.hasLoaded = true;
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
