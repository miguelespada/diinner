"use strict";

dinnerApp.controller('PreferencesCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'CityManager',
    'store',
    function(
      $scope,
      $state,
      $userManager,
      $cityManager,
      store
    ) {

  $scope.user = store.get('user');

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
      store.set('user', user);
      $state.go('profile');
      $scope.loading = false;
    });
  };
}]);
