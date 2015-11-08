"use strict";

dinnerApp.service('LoadingService', function($ionicLoading, BackActionService){
  var isLoading = false;
  var elementsLoading = 0;

  function loading(newValue, isSearching) {
    if(typeof newValue != 'undefined') {
      isLoading = newValue;
    }

    if(isLoading){
      var icon = isSearching ? 'ripple' : 'spiral';
      $ionicLoading.show({
        template: '<ion-spinner class="spinner-energized" icon="' + icon + '"></ion-spinner>'
      });
    } else {
      $ionicLoading.hide();
    }

    return isLoading;
  }

  function addLoading(){
    elementsLoading++;
    loading(true);
  }

  function removeLoading(){
    elementsLoading--;
    if(elementsLoading == 0){
      loading(false);
    }
  }

  return {
    loading: loading,
    addLoading: addLoading,
    removeLoading: removeLoading
  }
});

