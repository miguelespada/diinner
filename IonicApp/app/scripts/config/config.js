"use strict";

dinnerApp.config(function(ENV) {
  Stripe.setPublishableKey(ENV.stripePublishableKey);
});

dinnerApp.config(function($ionicConfigProvider) {
  $ionicConfigProvider.platform.android.views.transition("android");
});

dinnerApp.config(function(ENV, authProvider) {
  authProvider.init({
    domain: ENV.auth0Domain,
    clientID: ENV.auth0ClientID,
    loginState: 'index'
  });
});

dinnerApp.run(function(auth) {
  auth.hookEvents();
});

dinnerApp.run(function(auth, $rootScope, jwtHelper, $state) {
  var refreshingToken = null;
  $rootScope.$on('$locationChangeStart', function() {
    var token = JSON.parse(window.localStorage.getItem("token"));
    var refreshToken = JSON.parse(window.localStorage.getItem("refreshToken"));
    if (token) {
      if (!jwtHelper.isTokenExpired(token)) {
        if (!auth.isAuthenticated) {
          auth.authenticate(JSON.parse(window.localStorage.getItem("profile")), token);
        }
      } else {
        if (refreshToken) {
          if (refreshingToken === null) {
            refreshingToken = auth.refreshIdToken(refreshToken).then(function (idToken) {
              if(idToken != null){
                window.localStorage.setItem('token', JSON.stringify(idToken));
              }
              auth.authenticate(JSON.parse(window.localStorage.getItem("profile")), idToken);
            }).finally(function () {
              refreshingToken = null;
            });
          }
          return refreshingToken;
        } else {
          $state.go('index');
        }
      }
    }
  });
});

dinnerApp.config(function (authProvider, $httpProvider, jwtInterceptorProvider) {
  jwtInterceptorProvider.tokenGetter = function(jwtHelper, auth) {
    var idToken = JSON.parse(window.localStorage.getItem("token"));

    var refreshToken = JSON.parse(window.localStorage.getItem("refreshToken"));
    // If no token return null
    if (!idToken || !refreshToken) {
      return null;
    }
    // If token is expired, get a new one
    if (jwtHelper.isTokenExpired(idToken)) {
      return auth.refreshIdToken(refreshToken).then(function(idToken) {
        if (idToken != null){
          window.localStorage.setItem('token', JSON.stringify(idToken));
        }
        return idToken;
      });
    } else {
      return idToken;
    }
  };

  $httpProvider.interceptors.push('jwtInterceptor');

});

