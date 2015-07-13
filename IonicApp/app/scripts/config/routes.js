"use strict";

dinnerApp.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('index', {
      url: "",
      templateUrl: 'templates/links.html'
    })
    .state('user', {
      url: "/user",
      templateUrl: 'templates/user.html',
      controller: 'UserCtrl'
    })
    .state('profile', {
      url: "/profile",
      templateUrl: 'templates/profile.html'
    })
    .state('notifications', {
      url: "/notifications",
      templateUrl: 'templates/notifications.html'
    })
    .state('preferences', {
      url: "/preferences",
      templateUrl: 'templates/preferences.html'
    })
    .state('new_reservation', {
      url: "/new_reservation",
      templateUrl: 'templates/new_reservation.html'
    })
    .state('payment', {
      url: "/payment",
      templateUrl: 'templates/payment.html'
    })
    .state('my_reservations', {
      url: "/my_reservations",
      templateUrl: 'templates/my_reservations.html'
    })
});


