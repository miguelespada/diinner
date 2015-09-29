"use strict";

dinnerApp.service('LoadingService', function($ionicLoading, BackActionService){
  var isLoading = false;

  function loading(newValue) {
    if(typeof newValue != 'undefined') {
      isLoading = newValue;
    }

    if(isLoading){
      $ionicLoading.show({
        template: 'Loading...'
      });
    } else {
      $ionicLoading.hide();
    }

    return isLoading;
  }

  return {
    loading: loading
  }
});

