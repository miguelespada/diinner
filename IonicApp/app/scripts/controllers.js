dinnerApp.controller('UserCtrl', ['$scope', 'UserManager', function($scope, $userManager) {
  $scope.user = $userManager.getUser();
}]);

dinnerApp.controller('PreferencesCtrl', ['$scope', '$state', 'UserManager', 'CityManager', function($scope, $state, $userManager, $cityManager) {
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

