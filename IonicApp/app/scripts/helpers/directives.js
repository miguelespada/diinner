"use strict";

dinnerApp.directive('jsonDate', function() {
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function (scope, element, attrs, ngModel) {

      //format text going to user (model to view)
      ngModel.$formatters.push(function (value) {
        if (!value)
          return null;

        return new Date(value);
      });

      //format text from the user (view to model)
      ngModel.$parsers.push(function (value) {
        return value;
      });
    }
  }
});
