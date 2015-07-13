"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', function($resource, ENV) {
  this.getUser = function() {
    return $resource(ENV.apiEndPoint + '/user.json').get()
  };

  this.updateUser = function(user) {
    return $resource(ENV.apiEndPoint + '/user').save({user: user});
  };

  this.getNotifications = function() {
    return $resource(ENV.apiEndPoint + '/notifications.json').get()
  };

  this.getReservations = function() {
    return $resource(ENV.apiEndPoint + '/reservations.json').get()
  };

  this.cancelReservation = function(reservation_id) {
    return $resource(ENV.apiEndPoint + '/cancel_reservation').save({reservation_id: reservation_id})
  };
}]);


dinnerApp.service('CityManager',['$resource', 'ENV', function($resource, ENV) {
  this.getCities = function() {
    return $resource(ENV.apiEndPoint + '/cities.json').get();
  };
}]);


dinnerApp.service('TableManager',['$resource', 'ENV', function($resource, ENV) {
  this.searchTables = function(filters) {
    return $resource(ENV.apiEndPoint + '/table/search').get({filters: filters});
  };
}]);

