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
  function getProfile() {
    var profile = store.get('profile');
    return {
      userinfo: {
        info: {
          name: profile.name,
          email: profile.email,
          image: profile.picture
        }
      }
    }
  };

  return {
    getProfile: getProfile
  };

});




