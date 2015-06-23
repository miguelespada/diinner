"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', function($resource, ENV) {
  this.getUser = function() {
    return $resource(ENV.apiEndPoint + '/user.json').get()
  };

  this.updateUser = function(user) {
    return $resource(ENV.apiEndPoint + '/user').save({user: user});
  };

}]);


dinnerApp.service('CityManager',['$resource', 'ENV', function($resource, ENV) {
  this.getCities = function() {
    return $resource(ENV.apiEndPoint + '/cities.json').get();
  };
}]);
