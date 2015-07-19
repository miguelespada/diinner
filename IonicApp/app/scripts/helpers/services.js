"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', 'store', function($resource, ENV, store) {
  this.getUser = function() {
    var token = store.get('token');
    console.log(token);
    return $resource(ENV.apiEndPoint + '/user.json').get({user_token: token})
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

  this.reserve = function(reservation) {
    return $resource(ENV.apiEndPoint + '/reserve').save({reservation: reservation})
  };

  this.updateCustomer = function(payment_token) {
    return $resource(ENV.apiEndPoint + '/update_customer').save({payment_token: payment_token})
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

