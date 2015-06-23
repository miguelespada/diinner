"use strict";

dinnerApp.filter('stringToDate', function () {
  return function (input) {
    if (!input)
      return null;

    var date = moment(input);
    return date.isValid() ? date.toDate() : null;
  };
});
