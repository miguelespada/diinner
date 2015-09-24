"use strict";

dinnerApp.controller('RestaurantCtrl',
  [
    '$scope',
    'SharedService',
    'LoadingService',
    '$compile',
    function($scope,
             $sharedService,
             $loadingService,
             $compile
    ) {

      var reservation = $sharedService.get().reservationSelected;
      $scope.restaurant = reservation.restaurant;
      var location = reservation.restaurant.address || "Madrid, Spain";

      function initializeWithAddress(address){
        var geo = new google.maps.Geocoder;

        geo.geocode({'address':address},function(results, status){
          if (status == google.maps.GeocoderStatus.OK) {
            initialize(results[0].geometry.location);
          } else {
            console.log("Geocode was not successful for the following reason: " + status);
          }

        });
      }

      function initialize(location) {
        var myLatlng = location || new google.maps.LatLng(43.07493,-89.381388);
        var mapOptions = {
          center: myLatlng,
          zoom: 16,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map"),
          mapOptions);


        //Marker + infowindow + angularjs compiled ng-click
        var contentString = "<div><a ng-click='clickTest()'>" + reservation.restaurant.name + "</a></div>";
        var compiled = $compile(contentString)($scope);

        var infowindow = new google.maps.InfoWindow({
          content: compiled[0]
        });

        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Uluru (Ayers Rock)'
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map,marker);
        });

        $scope.map = map;
      }

      initializeWithAddress(location);




}]);
