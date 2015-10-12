"use strict";

dinnerApp.service('BackActionService',
  function($state,
           $ionicHistory){

    function goBackAction(){

      var newState = getBackState($ionicHistory.currentStateName());
      if (newState){
        newState === 'default' ? $ionicHistory.goBack() : $state.go(newState);
      }

    }

    function getBackState(actualState){

      switch (actualState){
        case 'profile':
        case 'notifications':
        case 'last_minute':
        case 'new_reservation':
        case 'my_reservations': return 'user';

        case 'test':
        case 'preferences': return 'profile';

        case 'reservation': return 'my_reservations';

        case 'login':
        case 'user': return false;

        case 'payment':
        case 'map':
        default: return 'default';

      }
    }

    return {
      goBackAction: goBackAction
    }
});

