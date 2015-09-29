"use strict";

dinnerApp.controller('PaymentCtrl',
  [
    '$scope',
    '$state',
    'UserManager',
    'SharedService',
    'LoadingService',
    'InitService',
    function($scope,
             $state,
             $userManager,
             $sharedService,
             $loadingService,
             $initService
    ) {
      $scope.reservationSelected = $sharedService.get().reservations.selected;

      $scope.updateUserData = function(user) {
        $scope.panelShown = user.payment.has_default_card ? 'payment_confirm' : 'change_card';
        $scope.paymentCard = user.payment.default_card;
      };

      $scope.user = $sharedService.get().user;
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
            $sharedService.set({user: user});
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
          $initService.initReservations();
          $loadingService.loading(false);
          $state.go('user');
        });
      };
}]);
