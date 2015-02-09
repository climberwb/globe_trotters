var locationSearch = function (location, cb) {
  $.post(
    "/teams/location_search",
    {"location": location},
    cb,
    "json");
};


$(function() {
  $('#team_loc_create').click(function( event ) {

   // event.preventDefault();
    var val = $("#team_location")[0].value;
    $('#location-list').empty();
    locationSearch(val, function(locations) {
      //$("#testing_modal")[0].modal("show")
      
      function possibleLocations(element, index, array) {
          $("<li>"+element+"</li>").appendTo('#location-list');
        }
      locations.forEach(possibleLocations);
      

    });


   });

  });