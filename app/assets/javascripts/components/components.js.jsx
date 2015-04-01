// TODO convert test to real friend request
var Decide = React.createClass({
  //TODO ajax post calles for accept and decline links

  handleSubmitAccept: function(e) {
    e.preventDefault();
    this.props.onSubmitAccept();//new////////////////
  },
  handleSubmitDecline: function(e) {
    e.preventDefault();
    this.props.onSubmitDecline();//new////////////////
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
    alert(this.props.user.friendStatus)
    if (this.props.user.friendStatus == true) {
      decision = <div>my friend</div>;
    } else {
      decision = <Decide onSubmitAccept={this.handleSubmitAccept} onSubmitDecline={this.handleSubmitDecline} />
    }
    return (
      <li>
          <img src={this.props.user.avatar}></img><a href={this.props.user.url}>{this.props.user.name}</a>
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
    alert(user.id);
    this.setState({ users:[user]});
    $.ajax({  //uncomment when done
      url: '/individual_relationships/accept',
      dataType: 'json',
      type: 'POST',
      data: {sender_id: user.id},
      success: function(data) {
        alert('dhdh');
        user.friendStatus = true;
        this.setState({ users:[user]});
      }.bind(this),
      error: function(xhr, status, err) {
           // user.friendStatus = true;

        console.error('/individual_relationships/accept', status, err.toString());
    }.bind(this)})
  },
  onDecline: function(user) {
    var index = this.state.users.indexOf(user);
        this.setState(this.state.splice(index, 1));
    // $.ajax({ //uncoment when done
    //   url: '/individual_relationships/decline',
    //   dataType: 'json',
    //   type: 'POST',
    //   data: user.id,
    //   success: function(data) {
    //     alert('dhdh');
    //     var index = this.state.users.indexOf(users);
    //     this.setState(this.state.splice(index, 1));
    //   }.bind(this),
    //   error: function(xhr, status, err) {
    //     console.error('/individual_relationships/accept', status, err.toString());
    // }.bind(this)})
  },
  componentDidMount: function() {
    $.get(this.props.source, function(data) { //uncomment when done
      this.setState({users: data.users});
    }.bind(this));

  },

  render: function() {
    var self = this;
    return (
      <ul>
        {this.state.users.map(function (user) {
          return <FriendInfo user={user} onAccept={self.onAccept} onDecline={self.onDecline}  />
        })}
      </ul>
    );
  }
});

// var RequestLinks= React.createClass({
//   render: function() {
//     return (
//       <div className="requestLinks" style={{float:"right"}}>
//         <a href="accept.com">accept</a>
//         <a href="deny.com">deny</a>
//       </div>
//     );
//   }
// });

var FriendBox = React.createClass({
  render: function() {
    return (
      <div className="friendBox">
        <FriendsInfo source="/individual_relationships/show"/>
      </div>
    );
  }
});
React.render(<FriendBox />,  document.getElementById('test'));
