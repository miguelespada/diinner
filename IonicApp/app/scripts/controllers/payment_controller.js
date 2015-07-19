"use strict";

dinnerApp.controller('PaymentCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    function($scope,
             $state,
             $userManager,
             $sharedService) {


  $scope.reservationSelected = $sharedService.get().reservationSelected;


  $scope.updateUserData = function(user) {
    $scope.panelShown = user.payment.has_default_card ? 'payment_confirm' : 'change_card';
    $scope.paymentCard = user.payment.default_card;
  };

  $scope.user = $userManager.getUser();
  $scope.user.$promise.then($scope.updateUserData );

  $scope.changeCard = function(){
    $scope.panelShown = 'change_card';
    $scope.cardError = false;
  };

  $scope.handleStripe = function(status, response){
    if(response.error) {
      $scope.cardError = true;
    } else {
      $userManager.updateCustomer(response.id).$promise.then(function(user) {
        $scope.user = user;
        $scope.updateUserData(user);
      });
      $scope.panelShown = 'payment_confirm';
    }
  };

  $scope.confirmPayment = function(){
    $userManager.reserve($scope.reservationSelected);
    $state.go('user');
  };
}]);
