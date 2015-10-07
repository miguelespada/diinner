"use strict";

dinnerApp.service('InitService',
  [ 'UtilService',
    'SharedService',
    'CityManager',
    'UserManager',
    function(
      $utilService,
      $sharedService,
      $cityManager,
      $userManager
    ) {

      function initDefault(){
        $cityManager.getCities().$promise.then(function(response) {
          $sharedService.set({
            default: {
              cityList: response.cities
            }
          });
        });

        var ageList = [];
        for (var i = 18; i < 65; i++){
          ageList.push(i);
        }

        $sharedService.set({
          default: {
            dateList: [
              {text: "Tomorrow", value: 'tomorrow'},
              {text: "Other Day", value: 'other'}
            ],
            friendsList: [
              {text: "1", value: 1},
              {text: "2", value: 2}
            ],
            genderList: [
              {text: "Female", value: "female"},
              {text: "Male", value: "male"}
            ],
            ageList: ageList,
            expectationList: [
              {text: "Diinner and Bed", value: 1},
              {text: "Diinner and Party", value: 2}
            ],
            priceList: [20, 40, 60]
          }
       });
      }

      function initUser(user, callbacks){
        $sharedService.set({user: user});
        var reservationsCallback = (callbacks != null) ? callbacks.reservations : null;
        var notificationsCallback = (callbacks != null) ? callbacks.notifications : null;
        initReservations(reservationsCallback);
        initNotifications(user, notificationsCallback);

      }

      function initNotifications(user, callback){
        $userManager.getNotifications().$promise.then(function(notifications) {
          var hasUnreadNotifications = notifications.length > 0 ? $utilService.isSameDate(notifications[notifications.length-1], user.notifications_read_last) : false;
          $sharedService.set({
            user: {
              hasUnreadNotifications: hasUnreadNotifications
            },
            notifications: {
              all: notifications
            }
          });
          if(callback != null){
            callback();
          }
        });
      }

      function initReservations(callback){
        $userManager.getReservations().$promise.then(function(response) {
          if (response) {
            var reservations = response.reservations;

            var todayReservation = (reservations.length > 0) && $utilService.isDateToday(reservations[reservations.length - 1].reservation.date) ? reservations[reservations.length - 1] : false;

            $sharedService.set({
              reservations: {
                hasReservations: true,
                all: reservations,
                today: todayReservation
              }
            });
          } else{
            $sharedService.set({
              reservations: {
                hasReservations: false
              }
            });
          }
          if(callback != null){
            callback();
          }
        });
      }

      function clear(){
        $sharedService.clear();
        initDefault();
      }

      return {
        initDefault: initDefault,
        initUser: initUser,
        initReservations: initReservations,
        initNotifications: initNotifications,
        clear: clear
      }

}]);
