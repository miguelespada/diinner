"use strict";

dinnerApp.service('BackActionService',
  [ '$state',
    '$ionicHistory',
    'SharedService',
  function($state,
           $ionicHistory,
           $sharedService){

    function goBackAction(){
      if ($sharedService.get().back.hasBackAction){
        $sharedService.set({
          back: {
            hasBackAction: false
          }
        });
        $sharedService.get().back.backAction();
      } else {
        var newState = getBackState($ionicHistory.currentStateName());
        if (newState) {
          newState === 'default' ? $ionicHistory.goBack() : $state.go(newState);
        }
      }

    }

    function getBackState(actualState){

      switch (actualState){
        case 'profile':
        case 'notifications':
        case 'new_reservation':
        case 'my_reservations': return 'user';

        case 'test':
        case 'preferences': return 'profile';

        //case 'reservation': return 'my_reservations';

        case 'login':
        case 'user': return false;

        case 'payment':
        case 'map':
        case 'reservation':
        default: return 'default';

      }
    }

    return {
      goBackAction: goBackAction
    }
}]);

