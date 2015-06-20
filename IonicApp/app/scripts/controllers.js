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

dinnerApp.controller('NewReservationCtrl', ['$scope', '$state', 'UserManager', 'CityManager', function($scope, $state, $userManager, $cityManager) {
  $scope.user = $userManager.getUser();
  $scope.cityList = $cityManager.getCities();

  $scope.friendsList = [
    { text: "Solo", value: 0 },
    { text: "+1", value: 1 },
    { text: "+2", value: 2 }
  ];

  $scope.expectationList = [
    { text: "Diinner and bed", value: 1 },
    { text: "Diinner and party", value: 2 }
  ];

  $scope.priceList = [ 20, 40, 60 ];

  $scope.panelShown = "search-form";

  $scope.user.$promise.then(function(user) {
    $scope.filters = {
      menu_price: user.preference.menu_price,
      city_id: user.preference.city_id
    };
  });


  $scope.searchReservations = function(filters){
    $scope.panelShown = "search-results";
  };
}]);
