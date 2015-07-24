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
  $scope.cityList = $cityManager.getCities();

  $scope.genderList = [
    { text: "Female", value: "female" },
    { text: "Male", value: "male" }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.editUser = function(){
    $userManager.updateUser($scope.user);
    store.set('user', $scope.user);
    $state.go('profile');
  };
}]);
