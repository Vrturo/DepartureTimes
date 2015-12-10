
var transitInit = $('#transit').on('click', function(e){
      e.preventDefault();
      var cb = function(responseData){
        console.log(responseData)
      };
      getTransitData(transit_api_url, 'GET', null, cb);
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
