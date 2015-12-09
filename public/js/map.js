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
      zoom: 17
    });
  }

$( document ).ready(function() {
  getLocation();
  initMap();
});
