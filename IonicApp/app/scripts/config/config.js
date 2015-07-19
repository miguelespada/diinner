"use strict";

dinnerApp.config(function(ENV) {
  Stripe.setPublishableKey(ENV.stripePublishableKey);
});


