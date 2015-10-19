"use strict";

dinnerApp.controller('FirstLoginCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    'UtilService',
    function(
      $scope,
      $state,
      $userManager,
      $sharedService,
      $loadingService,
      $utilService
    ) {

  $scope.user = $sharedService.get().user;
  $scope.cityList = $sharedService.get().default.cityList;
  $scope.genderList = $sharedService.get().default.genderList;

  $scope.ageError = false;

  $scope.noEmptyFields = function(){
    return $scope.user.preference != null && $scope.user.preference.city_id != null && $scope.user.gender != null && $scope.user.birth != null
  };

  $scope.editUser = function(){
    if($utilService.calculateAge($scope.user.birth) < 18) {
      $scope.ageError = true;
    } else {
      $loadingService.loading(true);
      $userManager.updateUser($scope.user).$promise.then(function (user) {
        if (user != null) {
          window.localStorage.setItem('user', JSON.stringify(user));
          $sharedService.set({user: user});
        }
        $state.go('user');
        $loadingService.loading(false);
      });
    }
  };

}]);
