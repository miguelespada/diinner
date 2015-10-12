"use strict";

dinnerApp.service('SharedService',['UtilService', function($utilService) {
  var savedData = {};

  function set(data) {
    savedData = $utilService.extendObject(savedData, data);
  }

  function get() {
    return savedData;
  }

  function clear(){
    savedData = {};
  }

  return {
    set: set,
    get: get,
    clear: clear
  }

}]);
