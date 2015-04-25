//TODO incorporate https://facebook.github.io/react/docs/forms.html

var UpdateLink  = React.createClass({

  UpdateAnswer: function(e){
    e.preventDefault();
    this.props.UpdateAnswer(e.target.name);
  },
  render: function () {
    return (
        <div>
          <a href="hello.com" name="edit" onClick={this.UpdateAnswer}>Edit</a> | <a href="hello.com" name="submit" onClick={this.UpdateAnswer}>Submit</a>
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
  
  UpdateAnswer: function(name){
      this.props.UpdateAnswer(name);
  },
  render: function () {
    var Update;
    this.props.answer.pendingStatus ? Update = <UpdateLink answer={this.props.answer} UpdateAnswer={this.UpdateAnswer} /> : Update = null
    return (
        <div>
          <EditLink answer={this.props.answer} />
          {Update}
        </div>
      )
  }

 });

var Answer = React.createClass({
  handleChange: function(event) {
    this.props.answer.answerContent=event.target.value;
    this.setState({answerContent:this.props.answer.answerContent});

  },
  UpdateAnswer: function(name){
          this.props.UpdateAnswer(this.props.answer,name);
  },
  updateLink: function(){
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
           if(this.props.answer.edit === false){
             display = <div onClick={this.updateLink}> <p>{this.props.answerContent} </p>  <a>update</a>   </div>
           }
           else{
            display = <div onDoubleClick={this.updateLink}> <textarea name="description" defaultValue={content} onChange={this.handleChange}></textarea> <a>show</a> <AnswerLinks answer={this.props.answer} UpdateAnswer={this.UpdateAnswer}  />  </div>
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

  UpdateAnswer: function(answer,name) {
    //e.preventDefault();
      this.props.UpdateAnswer(answer,name);
    
  },
  render: function () {
     ////alert(JSON.stringify(this.props.answer));
    return (
        <li>
          <Question questionContent={this.props.answer.questionContent} />
           <Answer answerContent={this.props.answer.answerContent} answer={this.props.answer} UpdateAnswer={this.UpdateAnswer} />
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
   UpdateAnswer: function(answer,name) {
    //e.preventDefault();
    ////alert(JSON.stringify(answer));
    if(name=="edit"){
       $.ajax({ type:"PATCH", 
          url:"/users/"+ answer.ownerId+"/answers/"+answer.answerId,       
          dataType:"json",        
          data:{"answer":{"content":answer.answerContent}},        
          success: function(data) {
           //this.setState({users: data.users});
           //alert('success! Update Answer');
           //alert(JSON.stringify(data));
           this.componentDidMount();
          }.bind(this),
          error: function(xhr, status, err) {
            //alert('fail :(')
            console.error("/users/"+ answer.ownerId+"/answers/"+answer.answerId, status, err.toString());
      }});//.bind(this)})
    }else if(name=="submit"){
      $.ajax({ type:"POST", 
          url:"/users/"+ answer.ownerId+"/answers/",       
          dataType:"json",        
          data:{"answer":{"content":answer.answerContent,"id":answer.answerId}},        
          success: function(data) {
           //this.setState({users: data.users});
           //alert('success! Update Answer');
           //alert(JSON.stringify(data));
           this.componentDidMount();
          }.bind(this),
          error: function(xhr, status, err) {
            //alert('fail :(')
            console.error("/users/"+ answer.ownerId+"/answers/"+answer.answerId, status, err.toString());
      }});//.bin
    }
  },
  NewAnswers: function(answer) {
    //e.preventDefault();
    ////alert(JSON.stringify(answer));
     $.ajax({ type:"GET", 
        url:"/users/"+ answer.ownerId+"/answers/",       
        dataType:"json",        
        data:{"_method":"delete"},        
        success: function(data) {
         //this.setState({users: data.users});
         //alert('success! New Answer');
         //alert(JSON.stringify(data));
         this.setState({users: data.users});
        }.bind(this),
        error: function(xhr, status, err) {
          //alert('fail :(')
          console.error("/users/"+ answer.ownerId+"/answers/", status, err.toString());
    }.bind(this)})
  },
  // onDelete: function(user) {
  //  // //alert(user.id);
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
  //  // //alert(user.id);
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

  //  ////alert(JSON.stringify(this.state,undefined,0)); USE TO DEBUG!!!!!!!!!
  //       var oldUsers=this.state.users;
  //  ////alert(JSON.stringify(oldUsers,undefined,0));USE TO DEBUG!!!!!!!!!

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
    var self = this;

    return(
      <ul >
        {this.state.answers.map(function (answer) {
          return <Session answer={answer} UpdateAnswer={self.UpdateAnswer} />
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