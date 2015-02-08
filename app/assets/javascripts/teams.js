var locationSearch = function (location, cb) {
  $.post(
    "/teams/location_search",
    {"location": location},
    cb,
    "json");
};


$(function() {
  $('#team_form').submit(function( event ) {

    event.preventDefault();
    var val = $("#team_location")[0].value;
    locationSearch(val, function(locations) {
      $("#testing_modal")[0].modal("show")
    });


   });

  });