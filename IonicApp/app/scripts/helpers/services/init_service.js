"use strict";

dinnerApp.service('InitService',
  [ 'UtilService',
    'SharedService',
    'CityManager',
    'UserManager',
    'LoadingService',
    function(
      $utilService,
      $sharedService,
      $cityManager,
      $userManager,
      $loadingService
    ) {

      function initDefault(){
        $loadingService.addLoading();
        $cityManager.getCities().$promise.then(function(response) {
          $sharedService.set({
            default: {
              cityList: response.cities
            }
          });
          $loadingService.removeLoading();
        });

        var ageList = [];
        for (var i = 18; i < 65; i++){
          ageList.push(i);
        }

        $sharedService.set({
          default: {
            dateList: [
              {text: "Today (Last Minute)", value: 'today'},
              {text: "Tomorrow", value: 'tomorrow'},
              {text: "Other Day", value: 'other'}
            ],
            friendsList: [
              {text: "1", value: 1},
              {text: "2", value: 2}
            ],
            genderList: [
              {text: "♀", value: "female"},
              {text: "♂", value: "male"}
            ],
            ageList: ageList,
            expectationList: [
              {text: "Diinner and Bed", value: 1},
              {text: "Diinner and Party", value: 2}
            ],
            priceList: [
              {text: 'Lowcost', value: 'lowcost'},
              {text: 'Regular', value: 'regular'},
              {text: 'Premium', value: 'premium'}
            ]
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
        $loadingService.addLoading();
        $userManager.getNotifications().$promise.then(function(notifications) {
          notifications = notifications.notifications;

          var hasUnreadNotifications = true;
          if (notifications.length > 0) {
            if (user.notifications_read_at != null) {
              var lastNotificationDate = new Date(notifications[notifications.length - 1].creation_date);
              var notificationReadDate = new Date(user.notifications_read_at);
              hasUnreadNotifications = notifications.length > 0 ? $utilService.compareDatesAndTimes("gt", lastNotificationDate, notificationReadDate) : false;
            }
          } else{
            hasUnreadNotifications = false;
          }
          $sharedService.set({
            user: {
              hasUnreadNotifications: hasUnreadNotifications
            },
            notifications: {
              all: notifications
            }
          });
          $loadingService.removeLoading();
          if(callback != null){
            callback();
          }
        });
      }

      function initReservations(callback){
        $loadingService.addLoading();
        $userManager.getReservations().$promise.then(function(response) {
        var res_hash = {};
        if (response) {
          var reservations = response.reservations;
          var todayReservation = (reservations.length > 0) && $utilService.isDateToday(reservations[reservations.length - 1].reservation.date) ? reservations[reservations.length - 1] : false;
          res_hash = {
            reservations: {
              hasReservations: true,
              all: reservations,
              today: todayReservation
            }
          };
        } else{
          res_hash = {
            reservations: {
              hasReservations: false
            }
          }
        }
        $sharedService.set(res_hash);
        $loadingService.removeLoading();
        if(callback != null){
          callback(res_hash);
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
