var locationSearch = function (location, cb) {
  $.post(
    "/users/location_search",
    {"location": location},
    cb,
    "json");
};

var ready;
ready = function() {

  $(document).on('click','#individual-location-list li',function(event){
       $('#individual_location').val($(this)[0].innerHTML);

       $(document).on('click','#save-address',function(event){
          $('#team_form').submit();
      });
    });
};

$(document).ready(function() {
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
});