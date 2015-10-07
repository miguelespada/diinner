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
          $sharedService.set({cityList: response.cities});
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

      function initUser(user){
        $sharedService.set({user: user});
        initReservations();
        initNotifications();
      }

      function initNotifications(){
        $userManager.getNotifications().$promise.then(function(notifications) {
          $sharedService.set({
            notifications: {
              hasNotifications: true,
              all: notifications
            }
          });
        });
      }

      function initReservations(){
        $userManager.getReservations().$promise.then(function(response) {
          if (response) {
            var reservations = response.reservations;
            var todayReservation = $utilService.isDateToday(reservations[reservations.length - 1].reservation.date) ? reservations[reservations.length - 1] : false;

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
