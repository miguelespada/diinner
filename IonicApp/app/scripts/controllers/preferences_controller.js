"use strict";

dinnerApp.controller('PreferencesCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    'BackActionService',
    function(
      $scope,
      $state,
      $userManager,
      $sharedService,
      $loadingService,
      $backActionService
    ) {
  $scope.user = $sharedService.get().user;
  $scope.cityList = $sharedService.get().default.cityList;
  $scope.genderList = $sharedService.get().default.genderList;
  $scope.priceList = $sharedService.get().default.priceList;


  $scope.editUserAndGoBack = function(){
    $scope.editUser();
    $backActionService.goBackAction();
  };

  $scope.editUser = function(){
    $loadingService.loading(true);
    $userManager.updateUser($scope.user).$promise.then(function(user) {
      if(user != null){
        window.localStorage.setItem('user', JSON.stringify(user));
        $sharedService.set({user: user});
      }
      $state.go('profile');
      $loadingService.loading(false);
    });
  };
}]);
