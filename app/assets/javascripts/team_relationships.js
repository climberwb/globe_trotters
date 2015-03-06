var TeamRelationship = function (sender,receiver, cb) {
  $.post(
    "/team_relationships/create",{"team_relationships":
    {"sender_team_id": sender,
     "receiver_team_id": receiver
  }},
    cb,
    "json");
};

$(function() {


  $('#new_team_relationship').click(function( event ) {
    event.preventDefault();
    var sender_team = $("#sender_team_relationship")[0].value;
    var receiver_team = $("#receiver_team_relationship")[0].value;
    $('#location-list').empty();
    TeamRelationship(sender_team,receiver_team, function(status) {
       document.getElementById('#AddFriendTeam').innerHTML = "Request Sent"

    });


   });
  // ready();



  });