"use strict";

dinnerApp.factory('Cities', ['DataLoader', function($dataLoader) {
  //return $dataLoader.getCities().$promise.then(function(response) {
  //  var cityList = [];
  //  angular.forEach(response.cities, function(city, key) {
  //    this.push({
  //        id: city._id.$oid,
  //        name: city.name,
  //        latitude: city.latitude,
  //        longitude: city.longitude
  //      }
  //    );
  //  }, cityList);
  //
  //  return cityList;
  //
  //}, function(response) {
  //    // something went wrong
  //    return $q.reject(response.data);
  //  });
}]);





