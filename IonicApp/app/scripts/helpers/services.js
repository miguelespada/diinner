"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', 'UserAuth0', function($resource, ENV, $userAuth0) {
  this.getUser = function() {
    return $resource(ENV.apiEndPoint + '/user.json').get({user_token: $userAuth0.getToken()})
  };

  this.updateUser = function(user) {
    return $resource(ENV.apiEndPoint + '/user').save({user_token: $userAuth0.getToken(), user: user});
  };

  this.getNotifications = function() {
    return $resource(ENV.apiEndPoint + '/notifications.json').get({user_token: $userAuth0.getToken()});
  };

  this.getReservations = function() {
    return $resource(ENV.apiEndPoint + '/reservations.json').get({user_token: $userAuth0.getToken()})
  };

  this.cancelReservation = function(reservation_id) {
    return $resource(ENV.apiEndPoint + '/cancel_reservation').save({user_token: $userAuth0.getToken(), reservation_id: reservation_id})
  };

  this.reserve = function(reservation) {
    return $resource(ENV.apiEndPoint + '/reserve').save({user_token: $userAuth0.getToken(), reservation: reservation})
  };

  this.updateCustomer = function(payment_token) {
    return $resource(ENV.apiEndPoint + '/update_customer').save({user_token: $userAuth0.getToken(), payment_token: payment_token})
  };

  this.getTest = function() {
    return $resource(ENV.apiEndPoint + '/test').get({user_token: $userAuth0.getToken()})
  };

  this.saveTest = function(test_id, test_response) {
    return $resource(ENV.apiEndPoint + '/save_test').save({user_token: $userAuth0.getToken(), test_id: test_id, test_response: test_response})
  };
}]);


dinnerApp.service('CityManager',['$resource', 'ENV', function($resource, ENV) {
  this.getCities = function() {
    return $resource(ENV.apiEndPoint + '/cities.json').get();
  };
}]);


dinnerApp.service('TableManager',['$resource', 'ENV', 'UserAuth0', function($resource, ENV, $userAuth0) {
  this.searchTables = function(filters) {
    return $resource(ENV.apiEndPoint + '/table/search').get({user_token: $userAuth0.getToken(), filters: filters});
  };

  this.searchLastMinute = function() {
    return $resource(ENV.apiEndPoint + '/table/last_minute').get({user_token: $userAuth0.getToken()});
  };
}]);

