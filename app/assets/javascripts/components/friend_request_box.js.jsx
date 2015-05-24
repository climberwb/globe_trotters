

//TODO incorporate react-bootstrap from commented code
// var Navbar = ReactBootstrap.Navbar;
// var Nav = ReactBootstrap.Nav;
// var NavItem = ReactBootstrap.NavItem;
// var MenuItem = ReactBootstrap.MenuItem;
// var DropdownButton = ReactBootstrap.DropdownButton;
// var navbarInstance = (
//   <Navbar brand='React-Bootstrap'>
//     <Nav>
//       <NavItem eventKey={1} href='#'>Link</NavItem>
//       <NavItem eventKey={2} href='#'>Link</NavItem>
//       <DropdownButton eventKey={3} title='Dropdown'>
//         <MenuItem eventKey='1'>Action</MenuItem>
//         <MenuItem eventKey='2'>Another action</MenuItem>
//         <MenuItem eventKey='3'>Something else here</MenuItem>
//         <MenuItem divider />
//         <MenuItem eventKey='4'>Separated link</MenuItem>
//       </DropdownButton>
//     </Nav>
//   </Navbar>
// );

// React.render(navbarInstance, document.getElementById('FriendBox'));








// TODO Refactor & Style
var Decide = React.createClass({

  handleSubmitAccept: function(e) {
    e.preventDefault();
    this.props.onSubmitAccept();
  },
  handleSubmitDecline: function(e) {
    e.preventDefault();
    this.props.onSubmitDecline();
  },
  render: function () {
    return (
        <span className="relationship" >
           <a name="accept" onClick={this.handleSubmitAccept}>accept</a> | <a name="decline" onClick={this.handleSubmitDecline}>decline</a>
        </span>
      )
  }

})


var FriendInfo = React.createClass({
  deleteFriend: function() {
    this.props.onDelete(this.props.user);
  },
  handleSubmitAccept: function() {
    this.props.onAccept(this.props.user);
  },///new////////
 //
  handleSubmitDecline: function() {
    this.props.onDecline(this.props.user);
  },
  render: function () {
    var decision;
    var friend;
    if(this.props.user.friendStatus == 'true') {
      decision = <span> <a href={this.props.user.conference_url}>chat!</a> | <a  onClick={this.deleteFriend}>unfriend :(</a></span>;
      friend = <span><img style={{margin:'0 10px 0 10px'}} src={this.props.user.avatar.avatar.small.url}></img><a href={this.props.user.url}>{this.props.user.name}</a></span>;

    }
    else if(this.props.user.friendStatus == 'false') {

      decision = <Decide onSubmitAccept={this.handleSubmitAccept} onSubmitDecline={this.handleSubmitDecline} />
      friend = <span><img src={this.props.user.avatar.avatar.small.url}></img> <a href={this.props.user.url}>{this.props.user.name}</a> </span>;

    }
    return (
      <li>
           {friend}
          {decision}
      </li>
      )
  }

})

var FriendsInfo = React.createClass({

  onAccept: function(user){
    this.props.onAccept(user);
  },

  onDecline: function(user){
    this.props.onDecline(user);
  },

  onDelete: function(user){
    this.props.onDelete(user);
  },


  render: function() {
    var self = this;

    return (
      <ul className="dropdown-menu" id="friend-menu" >

        {this.props.users.map(function (user) {
          //TODO Implement self.friendBoxVisible(user)) conditional;
          //self.friendBoxVisible(user);
          return <FriendInfo key={user.id} user={user}  onAccept={self.onAccept} onDecline={self.onDecline} onDelete={self.onDelete} />
        })}
      </ul>
    );
  }
});



var DropDown = React.createClass({
  render: function() {

    return (

      <a className="dropdown-toggle" href="#" data-toggle="" style={{display:this.props.style}}>
        <span className="glyphicon glyphicon-user" id="glyphicon" ></span>
      </a>
    );
  }
});
var FriendBox = React.createClass({
  //TODO Implement code below for FriendsBox info! add function to friendsBox that calls the function below
         //then write a conditional to yield Dropdown and FriendsInfo!

  // friendBoxVisible: function(user){
  //   //user.travel_status == "traveler" implies the current_user is a host
  //   //because a traveler sends requests to a host. A host sees requests from travelers
  //  // console.log('dfd');

  //  if((user.travel_status == "traveler" )|| user.travel_status=="host"&& user.friendStatus == "true"){
  //   console.log('true');
  //   console.log(user);


  //  }else{

  //   // console.log('false');
  //    // console.log('false');
  //    //     //console.log(user);
  //    //     this.setProps = user;
  //    //     console.log(this.props);
  //   // this.setState({friendState:true}).bind(this);
  //    ;
  //  }


 // },
  getInitialState: function() {
    return {
      users: [
         {id:1, url:"", name:"test user", friendStatus: "false"},
         //{id:2, url:"", name:"test user", friendStatus: "false"}
        // {id:2, url:"", name:"test user 2", friendStatus: true}
      ]
    };
  },
  onDelete: function(user) {
   // alert(user.id);
    var oldthis = this;
    //function deleteCall(){
      $('.loading').css('display','block');
      $.ajax({
        url: '/individual_relationships/delete',
        dataType: 'json',
        type: 'POST',
        data: {delete_friend:{user_id: user.id}},
        success: function(data) {
          oldthis.setState({users: data.users});
          window.location.href = '/';
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('/individual_relationships/delete', status, err.toString());
      }.bind(this)})
   // }
    // var r = confirm("are you sure you want to end your friend request?");
    // if (r == true) {
    //     deleteCall();
    // }
  },
  onAccept: function(user) {
    this.setState({ users:[user]});
    $('.loading').css('display','block');
    $.ajax({
      url: '/individual_relationships/accept',
      dataType: 'json',
      type: 'POST',
      data: {sender_id: user.id},
      success: function(data) {
        user.friendStatus = 'true';
        this.setState({ users:[user]});
        
       // alert('friend request complete. You will now redirect to a video chat with your new friend');
        //redirects to viconference
        window.location.href = '/vidconferences/'+data.vidconference_id;
      }.bind(this),
      error: function(xhr, status, err) {
        $('.loading').css('display','none');
        console.error('/individual_relationships/accept', status, err.toString());
    }.bind(this)})
  },
  onDecline: function(user) {

    var oldUsers=this.state.users;

    $.ajax({
      url: '/individual_relationships/decline',
      dataType: 'json',
      type: 'POST',
      data: {sender_id: user.id},
      success: function(data) {

        user.friendStatus = 'nil';
        var index = this.state.users.indexOf(user);
        var oldUsers=this.state.users;
         oldUsers.splice(index,index+1);

        this.setState({ users:oldUsers});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('/individual_relationships/decline', status, err.toString());
    }.bind(this)})
  },
  loadRelationshipsFromServer: function() {
    $.get("/individual_relationships/show", function(data) {
      this.setState({travel_status: data.travel_status,users: data.users});
    }.bind(this));

  },
  componentDidMount: function() {

    this.loadRelationshipsFromServer();
    //setInterval(alert('dfdf'), this.props.pollInterval);
    window.setInterval(this.loadRelationshipsFromServer, 8000);
  },

  redirect: function(userInfo){
    var urlVideo = window.location.href.match(/vidconference/g);
    console.log('dfd');
    //debugger;
     if( userInfo && userInfo.users&&userInfo.users.length==0&&urlVideo && urlVideo[0]==="vidconference"){
      //alert('your friendship has been deleted. Please find a new friend!')
       window.location.href = '/'
     }//TODO put || or in if else for production environment
     // else if(window.location.href == 'http://localhost:3000/'  && userInfo.users.length==1 && userInfo.users.friendStatus=="true"){
     //    alert('you now have a friend. You will be redirected to a video chat!');
     //    window.location.href = '/'
     // }
  },

  render: function() {
   // console.log(this.state);
    //console.log(this.props);
    var userInfo = this.state;
    var dropDown;
    var friendsInfo;
    //console.log(( userInfo.travel_status=="traveler"));]
    if(userInfo && userInfo.users&&userInfo.users.length >0&&(userInfo.users && userInfo.travel_status=="traveler" && userInfo.users[0].friendStatus =="true"||(userInfo.users && userInfo.users.length == 1 && userInfo.travel_status=="host"))){
       dropDown = <DropDown style={'block'} />
       friendsInfo = <FriendsInfo  users={this.state.users} onAccept={this.onAccept} onDecline={this.onDecline} onDelete={this.onDelete}/>
    }
    else{
      dropDown = <DropDown style={'none'} />
      this.redirect(userInfo);
            // console.log('df');

    }
      return (
        <li className="dropdown" id="friend_drop" >
          {dropDown}
          {friendsInfo}
        </li>
      );
  }
});

  React.render(<FriendBox />,  document.getElementById('FriendBox'));

$('#glyphicon').on('click', function(){

   $("#friend_drop").toggleClass("dropdown open");
});

