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
     var miles = .5;
     var circle = new google.maps.Circle({
            center: map.getCenter(),
            radius: miles * 1609.344, // 1 mile = 1609.344 meters
            fillColor: "#ff69b4",
            fillOpacity: 0.5,
            strokeOpacity: 0.0,
            strokeWeight: 0,
            map: map
        });

    var transitLayer = new google.maps.TransitLayer();
    transitLayer.setMap(map);

    var geocoder = new google.maps.Geocoder();
    $( "#transit" ).click(function(){
      geocodeAddress(geocoder, map);
    });
  }

function geocodeAddress(geocoder, resultsMap) {
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
        var infowindow = new google.maps.InfoWindow({
            title: results[0]["address_components"][0]["long_name"],
            content: results[0]["formatted_address"]
        });
         marker.addListener('click', function() {
            console.log(results[0]["address_components"][0]["long_name"]);
            infowindow.open(map, marker);
          });
        };
    });
  }
};



$( document ).ready(function() {
  getLocation();
  initMap();
});
