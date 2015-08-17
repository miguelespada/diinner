"use strict";

dinnerApp.controller('PreferencesCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'CityManager',
    function(
      $scope,
      $state,
      $userManager,
      $cityManager
    ) {

  $scope.user = JSON.parse(window.localStorage.getItem("user"));

  console.log($scope.user);
  $scope.cityList = $cityManager.getCities();

  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.editUser = function(){
    $scope.loading = true;
    $userManager.updateUser($scope.user).$promise.then(function(user) {
      if(user != null){
        window.localStorage.setItem('user', JSON.stringify(user));
      }
      $state.go('profile');
      $scope.loading = false;
    });
  };
}]);
