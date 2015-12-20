var x = document.getElementById("location");
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
var myMap = {};
function showPosition(position) {
    x.innerHTML = "Latitude: " + position.coords.latitude +
    "<br>Longitude: " + position.coords.longitude;
    initMap(position.coords.latitude, position.coords.longitude);
}
var map;
  function initMap(latt, lngg) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: latt, lng: lngg},
      zoom: 15
    });
    var marker = new google.maps.Marker({
      position: map.getCenter(),
      icon: {
        path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
        scale: 5
      },
      draggable: false,
      map: map
    });

    var transitLayer = new google.maps.TransitLayer();
    transitLayer.setMap(map);

    var geocoder = new google.maps.Geocoder();
    $( "#north" ).click(function(){
      geocodeAddress(geocoder, map, northArr, northStops);

    });
    $( "#south" ).click(function(){
      geocodeAddress(geocoder, map, southArr, southStops);
    });
  }

function geocodeAddress(geocoder, resultsMap, transitArr, stopsArr) {
  for (i = 0; i < transitArr.length; i++) {
    geocoder.geocode({'address': transitArr[i]}, function(results, status) {
      if (status === google.maps.GeocoderStatus.OK) {
        resultsMap.setZoom(11);
        var marker = new google.maps.Marker({
          map: resultsMap,
          position: results[0].geometry.location,
          icon: "/img/icontrain.png",
          draggable: false,
          map: map,
        });
         marker.addListener('click', function() {
            infowindow.open(map, marker);
          });
        var infowindow = new google.maps.InfoWindow({
            content: '<h3>' + results[0]["address_components"][0]["long_name"] + '</h3>'
        });

      };
    });
  }
};

$( document ).ready(function() {
  getLocation();
  initMap();
});
