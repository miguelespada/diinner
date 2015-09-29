"use strict";

dinnerApp.service('UserAuth0', function () {
  function getToken() {
    return JSON.parse(window.localStorage.getItem("token"));
  }

  return {
    getToken: getToken
  };

});
