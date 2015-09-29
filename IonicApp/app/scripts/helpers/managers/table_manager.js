"use strict";

dinnerApp.service('TableManager',['$resource', 'ENV', function($resource, ENV) {
  this.searchTables = function(filters) {
    return $resource(ENV.apiEndPoint + '/table/search').get({filters: filters});
  };

  this.searchLastMinute = function(filters) {
    return $resource(ENV.apiEndPoint + '/table/last_minute').get({filters: filters});
  };
}]);

