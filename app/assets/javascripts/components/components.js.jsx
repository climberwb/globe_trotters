// TODO convert test to real friend request
// tutorial2.js
var FriendInfo = React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  render: function() {
    return (
      <div className="friendInfo">
              <img src="http://upload.wikimedia.org/wikipedia/commons/thumb/9/92/SRC-TV.svg/140px-SRC-TV.svg.png"></img>
              <a href={JSON.stringify(this.props.url.users)}>link to profile</a>
      </div>
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
        <FriendInfo url="/individual_relationships/show"/>
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



