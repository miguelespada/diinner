// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic'])

.run(function($ionicPlatform) {
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
})

.config(function($stateProvider, $urlRouterProvider) {
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
    .state('notifications', {
      url: "/notifications",
      templateUrl: 'templates/notifications.html',
      controller: 'NotificationsCtrl'
    })
})

.controller('UserCtrl', ['$scope', '$http', function($scope, $http) {
  $http.get('http://localhost:3000/ionic/user.json').success(
    function(data){
      $scope.user = data.user;
    });
}])


;
