var map;
  function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 37.784577, lng: -122.397211},
      zoom: 15
    });
  }
$( document ).ready(function() {
  initMap();

});
