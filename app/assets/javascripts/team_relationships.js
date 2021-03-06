var TeamRelationship = function (sender,receiver, cb) {
  $.post(
    "/team_relationships/create",{"team_relationships":
    {"sender_team_id": sender,
     "receiver_team_id": receiver
  }},
    cb,
    "json");
};

var TeamAccept = function (sender,receiver, cb) {
  $.post(
    "/team_relationships/team_accept",{"team_relationships":
    {"sender_team_id": sender,
     "receiver_team_id": receiver
  }},
    cb,
    "json");
};

var TeamDecline = function (sender,receiver, cb) {
  $.post(
    "/team_relationships/team_decline",{"team_relationships":
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
      TeamRelationship(sender_team,receiver_team, function(status){
         document.getElementById('#AddFriendTeam').innerHTML = "Request Sent"
    });

   });
  // ready();
  
   $('.team-relationship-accept').click(function( event ) {
      event.preventDefault();
      var element = this;
      var receiver_team = $(this)[0].parentNode.className.split('-')[2];
      var sender_team = $(this)[0].parentNode.id.split('-')[2];
      
     //var receiver_team = $("#receiver_team_relationship")[0].value;
      TeamAccept(sender_team,receiver_team, function(status){
         if(status['status']=="Accept"){
          $('#team-relationship-list li').remove();
           $('#team-relationship-list').append('<li>'+'You are friends with: <a href='+ status['team']['link']+'>'+status['team']['name']+'</a>'+'</li>');            
         }
         else{
          alert('there was a problem with the server. Please Try again');
         }
    });

   });


   $('.team-relationship-decline').click(function( event ) {
    event.preventDefault();
    if( confirm('Are you sure you want to decline?')){
        var element = this;
        var receiver_team = $(this)[0].parentNode.className.split('-')[2];
        var sender_team = $(this)[0].parentNode.id.split('-')[2];
        
       //var receiver_team = $("#receiver_team_relationship")[0].value;
        TeamDecline(sender_team,receiver_team, function(status){
          if(status['status']=="Decline"){
            $(element)[0].parentNode.remove();
           }
           else{
            alert('there was a problem with the server. Please Try again');
           }
      });
     }
     });
    


  });