"use strict";

dinnerApp.service('UserManager',['$resource', 'ENV', 'UserAuth0', function($resource, ENV, $userAuth0) {
  this.getUser = function() {
    return $resource(ENV.apiEndPoint + '/user.json').get({user_profile: $userAuth0.getProfile()})
  };

  this.updateUser = function(user) {
    return $resource(ENV.apiEndPoint + '/user').save({user_profile: $userAuth0.getProfile(), user: user});
  };

  this.getNotifications = function() {
    return $resource(ENV.apiEndPoint + '/notifications.json').get({user_profile: $userAuth0.getProfile()});
  };

  this.getReservations = function() {
    return $resource(ENV.apiEndPoint + '/reservations.json').get({user_profile: $userAuth0.getProfile()})
  };

  this.cancelReservation = function(reservation_id) {
    return $resource(ENV.apiEndPoint + '/cancel_reservation').save({user_profile: $userAuth0.getProfile(), reservation_id: reservation_id})
  };

  this.reserve = function(reservation) {
    return $resource(ENV.apiEndPoint + '/reserve').save({user_profile: $userAuth0.getProfile(), reservation: reservation})
  };

  this.updateCustomer = function(payment_token) {
    return $resource(ENV.apiEndPoint + '/update_customer').save({user_profile: $userAuth0.getProfile(), payment_token: payment_token})
  };
}]);


dinnerApp.service('CityManager',['$resource', 'ENV', function($resource, ENV) {
  this.getCities = function() {
    return $resource(ENV.apiEndPoint + '/cities.json').get();
  };
}]);


dinnerApp.service('TableManager',['$resource', 'ENV', 'UserAuth0', function($resource, ENV, $userAuth0) {
  this.searchTables = function(filters) {
    return $resource(ENV.apiEndPoint + '/table/search').get({user_profile: $userAuth0.getProfile(), filters: filters});
  };
}]);

