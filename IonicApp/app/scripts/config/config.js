"use strict";

dinnerApp.config(function(ENV) {
  Stripe.setPublishableKey(ENV.stripePublishableKey);
});

dinnerApp.config(function(ENV, authProvider) {
  authProvider.init({
    domain: ENV.auth0Domain,
    clientID: ENV.auth0ClientID,
    loginState: 'login'
  });
});

dinnerApp.run(function(auth) {
  auth.hookEvents();
});

dinnerApp.run(function(auth, $rootScope, store, jwtHelper, $location) {
  var refreshingToken = null;
  $rootScope.$on('$locationChangeStart', function() {
    var token = store.get('token');
    var refreshToken = store.get('refreshToken');
    if (token) {
      if (!jwtHelper.isTokenExpired(token)) {
        if (!auth.isAuthenticated) {
          auth.authenticate(store.get('profile'), token);
        }
      } else {
        if (refreshToken) {
          if (refreshingToken === null) {
            refreshingToken = auth.refreshIdToken(refreshToken).then(function (idToken) {
              store.set('token', idToken);
              auth.authenticate(store.get('profile'), idToken);
            }).finally(function () {
              refreshingToken = null;
            });
          }
          return refreshingToken;
        } else {
          $location.path('/login');
        }
      }
    }
  });
});

dinnerApp.config(function (authProvider, $httpProvider, jwtInterceptorProvider) {
  // ...
  jwtInterceptorProvider.tokenGetter = function(store, jwtHelper, auth) {
    var idToken = store.get('token');

    var refreshToken = store.get('refreshToken');
    // If no token return null
    if (!idToken || !refreshToken) {
      return null;
    }
    // If token is expired, get a new one
    if (jwtHelper.isTokenExpired(idToken)) {
      return auth.refreshIdToken(refreshToken).then(function(idToken) {
        store.set('token', idToken);
        return idToken;
      });
    } else {
      return idToken;
    }
  };

  $httpProvider.interceptors.push('jwtInterceptor');
  // ...
});

