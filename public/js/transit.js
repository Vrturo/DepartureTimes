
var transitClick = $('#transit').on('click', function(e){
      e.preventDefault();
      console.log(stopName);
});


$(document).ready(function() {
    console.log(stopName);
    transitClick();
});
