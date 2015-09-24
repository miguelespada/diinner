"use strict";

dinnerApp.factory('SharedService', function() {
  var savedData = {};
  function set(data) {
    savedData = data;
  }
  function get() {
    return savedData;
  }

  return {
    set: set,
    get: get
  }

});

dinnerApp.factory('UserAuth0', function () {
  function getToken() {
    return JSON.parse(window.localStorage.getItem("token"));
  }

  return {
    getToken: getToken
  };

});

dinnerApp.factory('UtilService', function(){
  function chunkInRows(arr, size) {
    var newArr = [];
    for (var i=0; i<arr.length; i+=size) {
      newArr.push(arr.slice(i, i+size));
    }
    return newArr;
  }

  return {
    chunkInRows: chunkInRows
  }
});

dinnerApp.factory('LoadingService', function($ionicLoading){
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

dinnerApp.factory('BackActionService',
  function($state,
           $ionicHistory){

    function goBackAction(){

      var newState = getBackState($ionicHistory.currentStateName());
      console.log(newState);
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

