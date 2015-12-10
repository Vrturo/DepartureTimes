var transitHeaderUrl = "";
var transitHeader = $('#transitHeader').on('click', function(e){
      e.preventDefault();
      var cb = function(responseData){
        console.log(responseData)
      };
      getTransitData(transitHeaderUrl, 'GET', null, cb);
  });





var transitUrl = "http://services.my511.org/Transit2.0/GetStopsForRoutes.aspx?token=#{ ENV['TRANSIT_API_KEY'] }&routeIDF=WestCAT~10~LOOP|BART~917"
var transitInit = $('#transit').on('click', function(e){
      e.preventDefault();
      var cb = function(responseData){
        console.log(responseData)
      };
      getTransitData(transitUrl, 'GET', null, cb);
  });

var getTransitData = function(url, method, data, callback){
  $.ajax({
        url: url,
        method: method
      })
      .done(function(responseData){
        callback(responseData);
      })
      .fail(function(responseData){
       console.log("Failed, FIX IT!")
      });
  }


$(document).ready(function() {
  transitInit();
});
