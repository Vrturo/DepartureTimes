var transitHeaderUrl = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=58cb6407-ebd8-4d7d-894c-27da1e56e7e3";
var transitHeader = $('#transit').on('click', function(e){
      e.preventDefault();
      var cb = function(responseData){
        $("#transitHeader").replaceWith(responseData);
      };
      getTransitData(transitHeaderUrl, 'GET', null, cb);
  });



var transitUrl = 'http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?routeIDF=Caltrain~LOCAL~SB1&token=58cb6407-ebd8-4d7d-894c-27da1e56e7e3'
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
        method: method,
        dataType: 'jsonp'
      })
      .done(function(responseData){
        callback(responseData);
      })
      .fail(function(responseData){
       console.log("Failed, FIX IT!")
      });
  }


$(document).ready(function() {
  transitHeader();
  transitInit();
});
