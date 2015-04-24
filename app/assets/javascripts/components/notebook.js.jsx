var CreateLink  = React.createClass({

  render: function () {
    return (
        <div>
          <a href="hello.com">Create</a>
        </div>
      )
  }

 });


var EditLink  = React.createClass({

  render: function () {

    return (

        <div>
          <a href="hello.com">{JSON.stringify(this.props.answer)}</a>
        </div>
      )
  }

 });

var AnswerLinks = React.createClass({


  
  render: function () {
    var create;
    this.props.answer.pendingStatus ? create = <CreateLink answer={this.props.answer} /> : create = 'dfd'
    return (
        <div>
          <EditLink answer={this.props.answer}/>
          <CreateLink answer={this.props.answer} />
        </div>
      )
  }

 });

var Answer = React.createClass({

  updateLink: function(){
   // alert(JSON.stringify(this.props.answer));
  ///this.props.answer['edit'] = true;
    if(this.props.answer.edit === false){
       this.props.answer["edit"] = true
  }
  else{
      this.props.answer["edit"] = false
    }
      this.setState({answer: this.props.answer})
    },


  render: function () {

    var display;
    var content;
    this.props.answerContent ? content = this.props.answerContent : content = 'write here!';
   // alert(JSON.stringify(this.props.answer));
           if(this.props.answer.edit === false){
             display = <div onDoubleClick={this.updateLink}> <p>{this.props.answerContent} </p>  <a>update</a>   </div>
            // alert(this.props.answer.edit);
           }
           else{
            display = <div onDoubleClick={this.updateLink}> <textarea name="description" value={content}></textarea> <a>show</a> <AnswerLinks answer={this.props.answer} />  </div>
            // alert(this.props.answer.edit);
           }
    return (
        <div>
          {display}
        </div>
      )
  }

 });
////////////////////////////////////////////////
var Question = React.createClass({

  render: function () {
    return (
        <div>
          <h1>{this.props.questionContent} </h1>
        </div>
      )
  }

 });




var Session = React.createClass({

  // handleSubmitAccept: function(e) {
  //   e.preventDefault();
  //   this.props.onSubmitAccept();
  // },
  // handleSubmitDecline: function(e) {
  //   e.preventDefault();
  //   this.props.onSubmitDecline();
  // },
  render: function () {
     //alert(JSON.stringify(this.props.answer));
    return (
        <li>
          <Question questionContent={this.props.answer.questionContent} />
           <Answer answerContent={this.props.answer.answerContent} answer={this.props.answer} />
        </li>
      )
  }

 });



var Sessions = React.createClass({


  getInitialState: function() {
    return {
      answers: [
        // {id:1, url:"", name:"test user", friendStatus: false},
        // {id:2, url:"", name:"test user 2", friendStatus: true}
      ]
    };
  },
  // onDelete: function(user) {
  //  // alert(user.id);
  //   $.ajax({
  //     url: '/individual_relationships/delete',
  //     dataType: 'json',
  //     type: 'POST',
  //     data: {sender_id: user.id},
  //     success: function(data) {
  //         this.setState({users: data.users});
  //     }.bind(this),
  //     error: function(xhr, status, err) {

  //       console.error('/individual_relationships/delete', status, err.toString());
  //   }.bind(this)})
  // },
  // onAccept: function(user) {
  //  // alert(user.id);
  //   this.setState({ users:[user]});
  //   $.ajax({
  //     url: '/individual_relationships/accept',
  //     dataType: 'json',
  //     type: 'POST',
  //     data: {sender_id: user.id},
  //     success: function(data) {
  //       user.friendStatus = 'true';
  //       this.setState({ users:[user]});
  //     }.bind(this),
  //     error: function(xhr, status, err) {

  //       console.error('/individual_relationships/accept', status, err.toString());
  //   }.bind(this)})
  // },
  // onDecline: function(user) {

  //  //alert(JSON.stringify(this.state,undefined,0)); USE TO DEBUG!!!!!!!!!
  //       var oldUsers=this.state.users;
  //  //alert(JSON.stringify(oldUsers,undefined,0));USE TO DEBUG!!!!!!!!!

  //   $.ajax({
  //     url: '/individual_relationships/decline',
  //     dataType: 'json',
  //     type: 'POST',
  //     data: {sender_id: user.id},
  //     success: function(data) {

  //       user.friendStatus = 'nil';
  //       var index = this.state.users.indexOf(user);
  //       var oldUsers=this.state.users;
  //        oldUsers.splice(index,index+1);

  //       this.setState({ users:oldUsers});
  //     }.bind(this),
  //     error: function(xhr, status, err) {
  //       console.error('/individual_relationships/decline', status, err.toString());
  //   }.bind(this)})
  // },
  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      data.currentUser.answers.map(function(answer){
        answer["edit"] = false;
      })
      this.setState({answers: data.currentUser.answers});
    }.bind(this));

  },

  render: function() {
    //var self = this;

    return(
      <ul >
        {this.state.answers.map(function (answer) {
          return <Session answer={answer} />
        })}
      </ul>
    );
  }
});


var NoteBook = React.createClass({

  render: function() {
    return (
      <div  >
        <Sessions source="/users/1/answers"/>
      </div>
    );
  }
});

React.render(<NoteBook />,  document.getElementById('notebook'));
// $('#glyphicon').on('click', function(){

//    $("#friend_drop").toggleClass("dropdown open");
// });