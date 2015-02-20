var locationSearch = function (location, cb) {
  $.post(
    "/teams/location_search",
    {"location": location},
    cb,
    "json");
};


var ready;
ready = function() {

  $(document).on('click','#location-list li',function(event){
       $('#team_location').val($(this)[0].innerHTML);

       $(document).on('click','#save-address',function(event){
          $('#team_form').submit();
      });
    });
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
   ready();



  });

//$(document).on('page:load', ready);

