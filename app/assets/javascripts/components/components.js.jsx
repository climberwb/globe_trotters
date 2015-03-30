// TODO convert test to real friend request


var FriendInfo = React.createClass({
  render: function () {
    return (
      <li>
          <a href={this.props.url}>{this.props.name}</a>
      </li>
      )
  }

})

var FriendsInfo = React.createClass({
  getInitialState: function() {
    return {
      users: []
    };
  },

  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      this.setState({users: data.users});
    }.bind(this));
    // $.get(this.props.source, function(user) {
    //   var users= user["users"][0];
    //   if (this.isMounted()) {
    //     this.setState({
    //       url: users.url,
    //       name: users.name
    //     });
    //   }
    // }.bind(this));
  },

  render: function() {
    return (
      <ul>
        {this.state.users.map(function (user) {
          console.log(user)
          return <FriendInfo {...user} />
        })}
      </ul>
      // <div className="friendInfo">
      //         <img src="http://upload.wikimedia.org/wikipedia/commons/thumb/9/92/SRC-TV.svg/140px-SRC-TV.svg.png"></img>
      //         <a href={this.state.url}>{this.state.name}</a>
      // </div>
    );
  }
});

var RequestLinks= React.createClass({
  render: function() {
    return (
      <div className="requestLinks" style={{float:"right"}}>
        <a href="accept.com">accept</a>
        <a href="deny.com">deny</a>
      </div>
    );
  }
});

var FriendBox = React.createClass({
  render: function() {
    return (
      <div className="friendBox">
        <FriendsInfo source="/individual_relationships/show"/>
        <RequestLinks />
      </div>
    );
  }
});
React.render(<FriendBox />,  document.getElementById('test'));
// var Timer = React.createClass({
//   getInitialState: function() {
//     return {secondsElapsed: 0};
//   },
//   tick: function() {
//   //  $(function() {
//       // $( this ).click(function() {
//        // console.log(this.toSource());
//     this.setState({secondsElapsed: this.state.secondsElapsed + 1});
//   // });
//   //  });
//   },
//   componentDidMount: function() {
//     this.interval = setInterval(this.tick, 1000);
//   },
//   componentWillUnmount: function() {
//     clearInterval(this.interval);
//   },
//   render: function() {
//     return (
//       <div>Seconds Elapsed: {this.state.secondsElapsed}</div>
//     );
//   }
// });

// // $(function() {
// //   $( "#test" ).click(function() {
// React.render(<Timer name="Timer" />,  document.getElementById('test'));
// });

// });



