"use strict";

dinnerApp.controller('FirstLoginCtrl',
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

  $scope.cityList = $cityManager.getCities();

  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.editUser = function(){
    $scope.loading = true;
    $userManager.updateUser($scope.user).$promise.then(function(user) {
      if(user != null){
        window.localStorage.setItem('user', JSON.stringify(user));
      }
      $state.go('user');
      $scope.loading = false;
    });
  };
}]);
