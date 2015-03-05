var TeamRelationship = function (sender,receiver, cb) {
  $.post(
    "/team_relationships/create",{"team_relationships":
    {"sender_team_id": sender,
     "receiver_team_id": receiver
  }},
    cb,
    "json");
};


//var ready;
// ready = function() {

//   $(document).on('click','#location-list li',function(event){
//        $('#team_location').val($(this)[0].innerHTML);

//        $(document).on('click','#save-address',function(event){
//           $('#team_form').submit();
//       });
//     });
// };
//sender_team_relationship
//receiver_team_relationship
//##AddFriendTeam
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