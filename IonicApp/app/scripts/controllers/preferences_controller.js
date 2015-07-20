"use strict";

dinnerApp.controller('PreferencesCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'CityManager',
    '$ionicNavBarDelegate',
    function(
      $scope,
      $state,
      $userManager,
      $cityManager,
      $ionicNavBarDelegate
    ) {

  $ionicNavBarDelegate.showBackButton(true);
  $scope.user = $userManager.getUser();
  $scope.cityList = $cityManager.getCities();

  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.editUser = function(){
    $userManager.updateUser($scope.user)
    $state.go('profile');
  };
}]);
