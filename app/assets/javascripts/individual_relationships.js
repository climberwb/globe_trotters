var IndividualRelationship = function (sender,receiver, cb) {
  $.post(
    "/individual_relationships/create",{"individual_relationships":
    {"sender_id": sender,
     "receiver_id": receiver
  }},
    cb,
    "json");
};

$(function() {

  $('#AddFriend').click(function( event ) {

      event.preventDefault();
      var sender_team = $("#sender_individual_relationship")[0].value;
      var receiver_team = $("#receiver_individual_relationship")[0].value;
      IndividualRelationship(sender_team,receiver_team, function(status){
         document.getElementById('AddFriend').innerHTML = "Request Sent"
    });

   });

})