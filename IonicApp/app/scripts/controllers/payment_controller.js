"use strict";

dinnerApp.controller('PaymentCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             $loadingService
    ) {
      $scope.reservationSelected = $sharedService.get().reservationSelected;

      $scope.updateUserData = function(user) {
        $scope.panelShown = user.payment.has_default_card ? 'payment_confirm' : 'change_card';
        $scope.paymentCard = user.payment.default_card;
      };

      $scope.user = JSON.parse(window.localStorage.getItem("user"));
      $scope.updateUserData($scope.user);

      $scope.changeCard = function(){
        $scope.panelShown = 'change_card';
        $scope.cardError = false;
      };

      $scope.handleStripe = function(status, response){
        if(response.error) {
          $scope.cardError = true;
        } else {
          $loadingService.loading(true);
          $userManager.updateCustomer(response.id).$promise.then(function(user) {
            $scope.user = user;
            $scope.updateUserData(user);
            $loadingService.loading(false);
          });
          $scope.panelShown = 'payment_confirm';
        }
      };

      $scope.confirmPayment = function(){
        $loadingService.loading(true);
        $userManager.reserve($scope.reservationSelected).$promise.then(function(response) {
          $loadingService.loading(false);
          $state.go('user');
        });
      };
}]);
