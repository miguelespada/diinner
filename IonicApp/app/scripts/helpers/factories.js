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

dinnerApp.factory('UserAuth0', function (store) {
  function getToken() {
    return store.get('token');
  }

  return {
    getToken: getToken
  };

});




