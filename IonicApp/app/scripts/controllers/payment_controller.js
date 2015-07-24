"use strict";

dinnerApp.controller('PaymentCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'store',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             store) {

  $scope.reservationSelected = $sharedService.get().reservationSelected;


  $scope.updateUserData = function(user) {
    $scope.panelShown = user.payment.has_default_card ? 'payment_confirm' : 'change_card';
    $scope.paymentCard = user.payment.default_card;
  };

  $scope.user = store.get('user');
  $scope.updateUserData($scope.user);

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
