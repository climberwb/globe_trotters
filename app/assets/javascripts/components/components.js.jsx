
var Navbar = ReactBootstrap.Navbar;
var Nav = ReactBootstrap.Nav;
var NavItem = ReactBootstrap.NavItem;
var MenuItem = ReactBootstrap.MenuItem;
var DropdownButton = ReactBootstrap.DropdownButton;
var navbarInstance = (
  <Navbar brand='React-Bootstrap'>
    <Nav>
      <NavItem eventKey={1} href='#'>Link</NavItem>
      <NavItem eventKey={2} href='#'>Link</NavItem>
      <DropdownButton eventKey={3} title='Dropdown'>
        <MenuItem eventKey='1'>Action</MenuItem>
        <MenuItem eventKey='2'>Another action</MenuItem>
        <MenuItem eventKey='3'>Something else here</MenuItem>
        <MenuItem divider />
        <MenuItem eventKey='4'>Separated link</MenuItem>
      </DropdownButton>
    </Nav>
  </Navbar>
);

//React.render(navbarInstance, document.getElementById('FriendBox'));









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
        <span className="relationship">
          <a name="accept" onClick={this.handleSubmitAccept}>accept</a> |
          <a name="decline" onClick={this.handleSubmitDecline}>decline</a>
        </span>
      )
  }

})


var FriendInfo = React.createClass({
  handleSubmitAccept: function() {
    console.log(this.props)
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
      decision = <div>my friend</div>;
      friend = <span><img src={this.props.user.avatar}></img><a href={this.props.user.url}>{this.props.user.name}</a></span>;

    }
    else if(this.props.user.friendStatus == 'false') {

      decision = <Decide onSubmitAccept={this.handleSubmitAccept} onSubmitDecline={this.handleSubmitDecline} />
      friend = <span><img src={this.props.user.avatar}></img><a href={this.props.user.url}>{this.props.user.name}</a></span>;

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
  getInitialState: function() {
    return {
      users: [
        // {id:1, url:"", name:"test user", friendStatus: false},
        // {id:2, url:"", name:"test user 2", friendStatus: true}
      ]
    };
  },
  onAccept: function(user) {
   // alert(user.id);
    this.setState({ users:[user]});
    $.ajax({
      url: '/individual_relationships/accept',
      dataType: 'json',
      type: 'POST',
      data: {sender_id: user.id},
      success: function(data) {
        user.friendStatus = 'true';
        this.setState({ users:[user]});
      }.bind(this),
      error: function(xhr, status, err) {

        console.error('/individual_relationships/accept', status, err.toString());
    }.bind(this)})
  },
  onDecline: function(user) {

   //alert(JSON.stringify(this.state,undefined,0)); USE TO DEBUG!!!!!!!!!
        var oldUsers=this.state.users;
   //alert(JSON.stringify(oldUsers,undefined,0));USE TO DEBUG!!!!!!!!!

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
  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      this.setState({users: data.users});
    }.bind(this));

  },

  render: function() {
    var self = this;

    return (
      <ul className="dropdown-menu">
        {this.state.users.map(function (user) {
          return <FriendInfo user={user} onAccept={self.onAccept} onDecline={self.onDecline}  />
        })}
      </ul>
    );
  }
});

//React.render(<FriendsInfo source="/individual_relationships/show" />,  document.getElementById('FriendBox'));


var DropDown = React.createClass({
  render: function() {

    return (
      <a className="dropdown-toggle" href="#" data-toggle="dropdown">
        <span className="glyphicon glyphicon-user"></span>
      </a>
    );
  }
});
var FriendBox = React.createClass({
  render: function() {
    return (
      <li className="dropdown">
        <DropDown/>
        <FriendsInfo source="/individual_relationships/show"/>
      </li>
    );
  }
});

React.render(<FriendBox />,  document.getElementById('FriendBox'));

// var Menu = React.createClass({
//   render: function() {
//     return (
//       <ul className="nav nav-tabs">
//         <FriendBox />
//         <li><li/>
//       </ul>
//     );
//   }
// });
// React.render(<FriendBox />,  document.getElementById('FriendBox'));
