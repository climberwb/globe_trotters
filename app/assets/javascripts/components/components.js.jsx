// TODO convert test to real friend request
var Decide = React.createClass({
  //TODO ajax post calles for accept and decline links
  render: function () {
    return (
        <span className="relationship"  data={this.props.data}>
          <a name="accept">accept</a> | <a name="decline">decline</a>
        </span>
      )
  }

})

var FriendInfo = React.createClass({
  render: function () {
    return (
      <li>
          <img src={this.props.avatar}></img><a href={this.props.url}>{this.props.name}</a> <Decide data={this.props.id} /> 
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
  },

  render: function() {
    return (
      <ul>
        {this.state.users.map(function (user) {
          return <FriendInfo {...user} />
        })}
      </ul>
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



