"use strict";

var dinnerApp = angular.module(
  'starter',
  [
  'ionic',
  'ngResource',
  'environment',
  'ui.calendar',
  'angularPayments',
  'auth0',
  'angular-storage',
  'angular-jwt'
]);

dinnerApp.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleLightContent();
    }
  });
});



