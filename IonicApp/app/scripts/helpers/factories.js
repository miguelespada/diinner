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





