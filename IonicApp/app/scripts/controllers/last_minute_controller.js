"use strict";

dinnerApp.controller('LastMinuteCtrl',
  [
    'SharedService',
    function(
      $sharedService
    ) {
      $sharedService.set({
        search: {
          formType: 'lastMinute'
        }
      });
    }]);
