$(document).ready(function(){
  MAP.initializeMap();
  MAP.updateMapListener();
  MAP.addMarkers();
});

var MAP = {};

// TODO put in a config file
MAP.defaultLatLng = [40.416775, -3.703790];
MAP.markerColor = '#777777';

MAP.initializeMap = function(){
  L.mapbox.accessToken = $('#map-config').data('token');

  var mapStyle = $('#map-config').data('style');
  MAP.drawMapTiles(mapStyle, MAP.defaultLatLng);
  MAP.getCurrentPosition();
};

MAP.updateMapListener = function(){
  $('#restaurant_address').focusout(function(){
    MAP.updateMap();
  });
};

MAP.updateMap = function(){
  var googleAPIKey = $('#map-config').data('google-key');
  var address = $('#restaurant_address').val();
  var city = $('#restaurant_city_id option:selected').text();
  var str = address + ', ' + city;
  var queryUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + '\"' + str + '\"' + '&key=' + googleAPIKey;

  MAP.getGeolocation(queryUrl);
};

MAP.drawMapTiles = function(style, latlng){


  MAP.container = L.mapbox.map('map', style).setView(latlng, 30);
  MAP.container.scrollWheelZoom.disable();
};

MAP.getCurrentPosition = function(){
  var currentLat = $('.location').data('current-lat');
  var currentLng = $('.location').data('current-lng');
  MAP.getPosition(currentLat, currentLng);
};

MAP.getGeolocation = function(queryUrl){
  $.get(queryUrl, function(data){
    $('#restaurant_latitude').val(data.results[0].geometry.location.lat);
    $('#restaurant_longitude').val(data.results[0].geometry.location.lng);
    if (MAP.marker){
      MAP.removeOldMarker();
    }
    MAP.getPosition($('#restaurant_latitude').val(), $('#restaurant_longitude').val());
  });
};

MAP.getPosition = function(latStr, lngStr){
  var lat = parseFloat(latStr);
  var lng = parseFloat(lngStr);
  {
    MAP.setMapToPosition([lat, lng]);
  }
};

MAP.setMapToPosition = function(latlng){
  MAP.container.setView(latlng);
  MAP.addMarker(latlng);
};

MAP.addMarker = function(latlng){
  MAP.marker = L.marker(latlng,{
    icon: L.mapbox.marker.icon(
      {'marker-color': MAP.markerColor,
       'marker-symbol' : 'star',
       'marker-size' : 'medium',
     }),
    draggable: false
  }).addTo(MAP.container);
};

MAP.removeOldMarker = function(){
  MAP.container.removeLayer(MAP.marker);
};

MAP.addMarkers = function(){
  $( "#markers .location" ).each( function( ){
    var lat = parseFloat($(this).data('current-lat'));
    var lng = parseFloat($(this).data('current-lng'));
    if (lat && lng)
        MAP.addMarker([lat, lng, name, link]);
  });
};