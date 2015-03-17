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