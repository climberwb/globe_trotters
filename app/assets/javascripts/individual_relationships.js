var IndividualRelationship = function (sender,receiver, cb) {
  $.post(
    "/individual_relationships/create",{"individual_relationships":
    {"sender_id": sender,
     "receiver_id": receiver
  }},
    cb,
    "json");
};

var Accept = function (sender,receiver, cb) {
  $.post(
    "/individual_relationships/accept",{"individual_relationships":
    {"sender_id": sender,
     "receiver_id": receiver
  }},
    cb,
    "json");
};

var Decline = function (sender,receiver, cb) {
   $.post(
    "/individual_relationships/decline",{"individual_relationships":
    {"sender_id": sender,
     "receiver_id": receiver
  }},
    cb,
    "json");
};
var Remove = function (sender,receiver,element) {
  $.ajax({
        url: '/individual_relationships/destroy',
        dataType: 'json',
        type: 'DELETE',
        data: {"individual_relationships":{"sender_id": sender, "receiver_id": receiver}},
        success: function(cb) {
          console.log(cb);
          $(element)[0].innerHTML = "FriendRemoved";
          $(element).attr("disabled","disabled");
        },
        error: function(xhr, status, err) {
          console.error('/individual_relationships/delete', status, err.toString());
      }
    })
}
   

$(function() {

  $('#AddFriend').click(function( event ) {
      var self = this;
      event.preventDefault();
      var sender_team = $("#sender_individual_relationship")[0].value;
      var receiver_team = $("#receiver_individual_relationship")[0].value;
      IndividualRelationship(sender_team,receiver_team, function(status){
        
        $(self)[0].innerHTML = "Request Sent";
        $(self).attr("disabled","disabled");
         
    });

   });
  $('#RemoveFriend').click(function( event ) {

      event.preventDefault();
      var sender_team = $("#sender_individual_relationship")[0].value;
      var receiver_team = $("#receiver_individual_relationship")[0].value;
      Remove(sender_team,receiver_team,this);

   });

   $('.individual-relationship-accept').click(function( event ) {
      event.preventDefault();
      var element = this;
      var receiver = $(this)[0].parentNode.className.split('-')[2];
      var sender = $(this)[0].parentNode.id.split('-')[2];
      
     //var receiver_team = $("#receiver_team_relationship")[0].value;
      Accept(sender,receiver, function(status){
         if(status['status']=="Accept"){
          $('#individual-relationship-list li').remove();
           $('#individual-relationship-list').append('<li>'+'You are friends with: <a href='+ status['individual']['link']+'>'+status['individual']['name']+'</a>'+'</li>');            
         }
         else{
          alert('there was a problem with the server. Please Try again');
         }
    });

   });


   $('.individual-relationship-decline').click(function( event ) {
    event.preventDefault();
    if( confirm('Are you sure you want to decline?')){
        var element = this;
        var receiver = $(this)[0].parentNode.className.split('-')[2];
        var sender = $(this)[0].parentNode.id.split('-')[2];
        
       //var receiver_team = $("#receiver_team_relationship")[0].value;
        Decline(sender,receiver, function(status){
          if(status['status']=="Decline"){
            $(element)[0].parentNode.remove();
           }
           else{
            alert('there was a problem with the server. Please Try again');
           }
      });
     }
     });
    


})