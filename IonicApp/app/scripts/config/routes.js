"use strict";

dinnerApp.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('index', {
      url: "",
      templateUrl: 'templates/splash.html'
    })
    .state('login', {
      url: "/login",
      templateUrl: 'templates/login.html'
    })
    .state('first_login', {
      url: "/first_login",
      templateUrl: 'templates/first_login.html'
    })
    .state('user', {
      url: "/user",
      templateUrl: 'templates/user.html'
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
    .state('last_minute', {
      url: "/last_minute",
      templateUrl: 'templates/last_minute.html'
    })
    .state('payment', {
      url: "/payment",
      templateUrl: 'templates/payment.html'
    })
    .state('my_reservations', {
      url: "/my_reservations",
      templateUrl: 'templates/my_reservations.html'
    })
    .state('reservation', {
      url: "/reservation",
      templateUrl: 'templates/reservation.html'
    })
    .state('test', {
      url: "/test",
      templateUrl: 'templates/test.html'
    })
    .state('restaurant', {
      url: "/restaurant",
      templateUrl: 'templates/restaurant.html'
    })
});


