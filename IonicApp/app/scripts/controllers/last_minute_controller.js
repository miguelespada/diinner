"use strict";

dinnerApp.controller('LastMinuteCtrl',
  [
    'SharedService',
    function(
      $sharedService
    ) {
      $sharedService.set({searchFormType: 'lastMinute'});
    }]);
