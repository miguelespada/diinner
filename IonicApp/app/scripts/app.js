"use strict";

var dinnerApp = angular.module(
  'starter',
  [
    'ionic',
    'ngResource',
    'environment',
    'ui.calendar',
    'rzModule',
    'angularPayments',
    'auth0',
    'angular-storage',
    'angular-jwt',
    'ngCordova'
]);

dinnerApp.run(function($ionicPlatform) {

  $ionicPlatform.ready(function() {
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleLightContent();
    }

    Ionic.io();

    var push = new Ionic.Push({
      debug: true,
      canShowAlert: true,
      canSetBadge: true,
      canPlaySound: true,
      canRunActionsOnWake: true,
      onNotification: function(notification) {
        console.log(notification);

        return true;
      },
      onRegister: function(data) {
        console.log(data);
        return true;
       }
     });


    push.register(function(token) {
      console.log("Device token:",token.token);
    });
  });

});



