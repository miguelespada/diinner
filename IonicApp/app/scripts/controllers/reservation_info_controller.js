"use strict";

dinnerApp.controller('ReservationInfoCtrl',
  [
    '$scope',
    '$state',
    function($scope,
             $state) {

  $scope.openRestaurant = function(){
    $state.go('restaurant');
  };

}]);
