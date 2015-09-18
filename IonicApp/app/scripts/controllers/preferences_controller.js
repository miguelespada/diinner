"use strict";

dinnerApp.controller('PreferencesCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'CityManager',
    'LoadingService',
    function(
      $scope,
      $state,
      $userManager,
      $cityManager,
      $loadingService
    ) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  $loadingService.loading(true);
  $cityManager.getCities().$promise.then(function(cities) {
    $scope.cityList = cities;
    $loadingService.loading(false);
  });



  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.editUser = function(){
    $loadingService.loading(true);
    $userManager.updateUser($scope.user).$promise.then(function(user) {
      if(user != null){
        window.localStorage.setItem('user', JSON.stringify(user));
      }
      $loadingService.loading(false);
      $state.go('profile');
    });
  };
}]);
