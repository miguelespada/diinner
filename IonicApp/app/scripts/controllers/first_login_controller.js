"use strict";

dinnerApp.controller('FirstLoginCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    function(
      $scope,
      $state,
      $userManager,
      $sharedService,
      $loadingService
    ) {

  $scope.user = $sharedService.get().user;
  $scope.cityList = $sharedService.get().default.cityList;
  $scope.genderList = $sharedService.get().default.genderList;

  $scope.editUser = function(){
    $loadingService.loading(true);
    $userManager.updateUser($scope.user).$promise.then(function(user) {
      if(user != null){
        window.localStorage.setItem('user', JSON.stringify(user));
        $sharedService.set({user: user});
      }
      $state.go('user');
      $loadingService.loading(false);
    });
  };
}]);
