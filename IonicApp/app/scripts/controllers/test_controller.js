"use strict";

dinnerApp.controller('TestCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    function($scope,
             $state,
             $userManager) {
      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $scope.response = $userManager.getTest();

      $scope.response.$promise.then(function(response) {
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
