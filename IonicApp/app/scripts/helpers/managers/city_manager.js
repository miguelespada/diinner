"use strict";

dinnerApp.service('CityManager',['$resource', 'ENV', function($resource, ENV) {
  this.getCities = function() {
    return $resource(ENV.apiEndPoint + '/cities.json').get();
  };
}]);
