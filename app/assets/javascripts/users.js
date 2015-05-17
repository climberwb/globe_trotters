var locationSearch = function (location, cb) {
  $.post(
    "/location_search",
    {"location": location},
    cb,
    "json");
};

var ready;
ready = function() {

  $(document).on('click','#individual-location-list li',function(event){
       $('#individual_location').val($(this)[0].innerHTML);
       $('#individual-location-list li').css('color','black');
       $(this).css('color','red');
       $(document).on('click','#save-individual-address',function(event){
          $('#individual_form').submit();
      });
    });
};

$(document).ready(function() {

    $('#individual_loc_create').click(function( event ) {
    event.preventDefault();
    var val = $('#individual_location')[0].value;
    $('#individual-location-list').empty();
    locationSearch(val, function(locations) {
      //$("#testing_modal")[0].modal("show")

      function possibleLocations(element, index, array) {
          $("<li>"+element+"</li>").appendTo('#individual-location-list');
        }
      locations.forEach(possibleLocations);

    });
    ready();
});
    // put all your jQuery goodness in here.
    $('#role_button_captain').click(function() {
       $('#user_role_attribute').val('captain');
    });

    $('#role_button_teammate').click(function() {
        $('#user_role_attribute').val('teammate');
    });
    $('#role_button_individual').click(function() {
        $('#user_role_attribute').val('individual');
    });


    // type of travelor for individual form
    $('#travel_status_button_host').click(function() {
        $('#travel_status_input').val('host');
    });
    $('#travel_status_button_traveler').click(function() {
        $('#travel_status_input').val('traveler');
    });
});