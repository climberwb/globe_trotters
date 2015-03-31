// TODO convert test to real friend request
var Decide = React.createClass({
  //TODO ajax post calles for accept and decline links

  handleSubmitAccept: function(e) {
    alert(this.props.data);
    e.preventDefault();
    this.props.onSubmitAccept({sender_id: this.props.data});//new////////////////
  },
  render: function () {
    return (
        <span className="relationship"  data={this.props.data}>
          <a name="accept" onClick={this.handleSubmitAccept}>accept</a> | <a name="decline">decline</a>
        </span>
      )
  }

})

var FriendInfo = React.createClass({
  handleSubmitAccept:  function(user) {//new////////
   // alert(user.sender_id);
        var sender_id = user;
       // var newComments = comments.concat([comment]);
        this.setState({data: sender_id});
        $.ajax({
      url: '/individual_relationships/accept',
      dataType: 'json',
      type: 'POST',
      data: sender_id,
      success: function(data) {
        alert("hello");
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('/individual_relationships/accept', status, err.toString());
      }.bind(this)
    });
  },///new////////
 //
  render: function () {
    return (
      <li>
          <img src={this.props.avatar}></img><a href={this.props.url}>{this.props.name}</a> <Decide onSubmitAccept={this.handleSubmitAccept} data={this.props.id} />
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
