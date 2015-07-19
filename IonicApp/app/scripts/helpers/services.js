"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', 'store', function($resource, ENV, store) {
  this.getUser = function() {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/user.json').get({user_token: token})
  };

  this.updateUser = function(user) {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/user').save({user_token: token, user: user});
  };

  this.getNotifications = function() {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/notifications.json').get({user_token: token});
  };

  this.getReservations = function() {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/reservations.json').get({user_token: token})
  };

  this.cancelReservation = function(reservation_id) {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/cancel_reservation').save({user_token: token, reservation_id: reservation_id})
  };

  this.reserve = function(reservation) {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/reserve').save({user_token: token, reservation: reservation})
  };

  this.updateCustomer = function(payment_token) {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/update_customer').save({user_token: token, payment_token: payment_token})
  };
}]);


dinnerApp.service('CityManager',['$resource', 'ENV', 'store', function($resource, ENV, store) {
  this.getCities = function() {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/cities.json').get({user_token: token});
  };
}]);


dinnerApp.service('TableManager',['$resource', 'ENV', 'store', function($resource, ENV, store) {
  this.searchTables = function(filters) {
    var token = store.get('token');
    return $resource(ENV.apiEndPoint + '/table/search').get({user_token: token, filters: filters});
  };
}]);

