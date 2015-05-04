$(document).ready(function(){
  MAP.initializeMap();
});

var MAP = {};

MAP.initializeMap = function(){
  var mapStyle = $('#map-config').data('style');
  var mapToken = $('#map-config').data('token');
  MAP.container = L.mapbox.map('restaurant-map', mapStyle, {
   accessToken: mapToken
 }).setView([40.416775, -3.703790], 14);
};