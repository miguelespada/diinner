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
    .state('preferences', {
      url: "/preferences",
      templateUrl: 'templates/preferences.html'
    })
});


