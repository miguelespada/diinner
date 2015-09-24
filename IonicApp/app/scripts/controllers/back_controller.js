"use strict";

dinnerApp.controller('BackCtrl',
  [
    '$scope',
    '$ionicPlatform',
    'BackActionService',
    function($scope,
             $ionicPlatform,
             $backActionService
    ) {
      $ionicPlatform.registerBackButtonAction(function (e) {
        console.log("backbutton pressed");
        console.log(e);
        e.preventDefault();
        e.stopImmediatePropagation();
        e.stopPropagation();
        $backActionService.goBackAction();
      }, 100);

      $scope.goBackAction = $backActionService.goBackAction;
}]);
