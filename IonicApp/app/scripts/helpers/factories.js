"use strict";

dinnerApp.service('SharedService',['UtilService', function($utilService) {
  var savedData = {};

  function set(data) {
    savedData = $utilService.extendObject(savedData, data);
  }

  function get() {
    return savedData;
  }



  return {
    set: set,
    get: get
  }

}]);

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

  function extendObject(destination, source) {
    for (var property in source) {
      destination[property] = source[property];
    }
    return destination;
  }

  function dateValue(stringValue, quantity){
    var oneDay = 24 * 60 * 60 * 1000;
    switch(stringValue){
      case "today": return new Date(); break;
      case "tomorrow": return new Date(new Date().getTime() + oneDay); break;
      case "afterTomorrow": return new Date(new Date().getTime() + oneDay * (quantity ? 1 + quantity : 2)); break;
      default: return new Date();
    }
  }

  function dateToString(date){
    var dd = date.getDate();
    var mm = date.getMonth()+1; //January is 0!
    var yyyy = date.getFullYear();

    if(dd<10) {
      dd='0'+dd
    }

    if(mm<10) {
      mm='0'+mm
    }

    return dd+'/'+mm+'/'+yyyy;
  }

  function stringToDate(strDate){
    var dateParts = strDate.split("/");
    return new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
  }

  return {
    chunkInRows: chunkInRows,
    extendObject: extendObject,
    dateToString: dateToString,
    stringToDate: stringToDate,
    dateValue: dateValue
  }
});

dinnerApp.factory('LoadingService', function($ionicLoading, BackActionService){
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
  function rejectedPromise(){
    loading(false);
    BackActionService.goBackAction();
  }

  return {
    loading: loading,
    rejectedPromise: rejectedPromise
  }
});

dinnerApp.factory('BackActionService',
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

