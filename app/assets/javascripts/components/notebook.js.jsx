//TODO incorporate https://facebook.github.io/react/docs/forms.html

var Col = ReactBootstrap.Col;
// var md = ReactBootstrap.Col.propTypes.md;
// var xsOffset = ReactBootstrap.Col.propTypes.xsOffset;
var Button = ReactBootstrap.Button;
var UpdateLink  = React.createClass({

  UpdateAnswer: function(e){
    e.preventDefault();
    this.props.UpdateAnswer(e.target.name);
  },
  render: function () {
    var submit;

    this.props.answer.pendingStatus ? submit=<Button className="btn btn-success submit_answer_btn" href="hello.com" name="submit" onClick={this.UpdateAnswer} >Submit</Button> : submit = null
    return (
        <div>
          <Button className="btn" href="hello.com" name="edit" onClick={this.UpdateAnswer} >Edit</Button> {submit}
        </div>
      )
  }

 });


var EditLink  = React.createClass({

  render: function () {

    return (
        <div>
          <p className="displayPara">{this.props.answer.answerContent}</p>
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
    var editNonPending;
    //this.props.answer.pendingStatus ? Update = <UpdateLink answer={this.props.answer} UpdateAnswer={this.UpdateAnswer} /> : Update = null

    return (
        <div  style={{width:"100%", position:"relative",left:"78px"}} >
          <EditLink answer={this.props.answer} />
          <UpdateLink style={{marginLeft:"60px"}}answer={this.props.answer} UpdateAnswer={this.UpdateAnswer} />
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
  // IMPORTANT! add s in front of https otherwise video will not rendor
  // IMPORTANT! for all youtube videos use embeded urls
var Video = React.createClass({

  render: function () {
    return (
        <div>
          <iframe className="youtube-player"
width="320" height="195" src={this.props.videoUrl}
frameBorder="0"></iframe>
        </div>
      )
  }

 });




var Session = React.createClass({

  UpdateAnswer: function(answer,name) {
    this.props.UpdateAnswer(answer,name);
  },
  render: function () {
    return (
        <div className="row session_box">
            <div className="row">
              <h2>{this.props.answer.questionContent}</h2>
            </div>
            <div className="row">
              <Col md={4} xsOffset={2}>
                <Video videoUrl={this.props.answer.videoUrl} />
              </Col>
              <Col md={4} className="answer">
                <Answer answerContent={this.props.answer.answerContent} answer={this.props.answer} UpdateAnswer={this.UpdateAnswer} />
              </Col>
            </div>
        </div>
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

    if(name=="edit"){
       $.ajax({ type:"PATCH",
          url:"/users/"+ answer.ownerId+"/answers/"+answer.answerId,
          dataType:"json",
          data:{"answer":{"content":answer.answerContent}},
          success: function(data) {

           this.componentDidMount();
          }.bind(this),
          error: function(xhr, status, err) {
            console.error("/users/"+ answer.ownerId+"/answers/"+answer.answerId, status, err.toString());
      }});//.bind(this)})
    }else if(name=="submit"){
      $.ajax({ type:"POST",
          url:"/users/"+ answer.ownerId+"/answers/",
          dataType:"json",
          data:{"answer":{"content":answer.answerContent,"id":answer.answerId}},
          success: function(data) {
            //TODO replace below logic with modal that says congrates make friends

            //length is the remaining length of the route ie. localhost:300/users/1/answers/show
            var urlArray = window.location.href.split('/');
            var length = window.location.href.split('/').length;
            if(urlArray[length-1] == "show" && urlArray[length-2] == "answers" && answer.lastAnswer){
              alert('you have completed the notebook. Time to find a friend!!');
              window.location.href = '/'; //redirects to different page if last answer is hit
            }
            else{
            this.componentDidMount();
          }
          }.bind(this),
          error: function(xhr, status, err) {
            console.error("/users/"+ answer.ownerId+"/answers/"+answer.answerId, status, err.toString());
      }});
    }
  },
  NewAnswers: function(answer) {

     $.ajax({ type:"GET",
        url:"/users/"+ answer.ownerId+"/answers/",
        dataType:"json",
        data:{"_method":"delete"},
        success: function(data) {
         this.setState({users: data.users});
        }.bind(this),
        error: function(xhr, status, err) {
        console.error("/users/"+ answer.ownerId+"/answers/", status, err.toString());
    }.bind(this)})
  },

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
      <div >
        {this.state.answers.map(function (answer) {
          return <Session key={answer.answerId} answer={answer} UpdateAnswer={self.UpdateAnswer} />
        })}
      </div>
    );
  }
});


var NoteBook = React.createClass({

  render: function() {
    return (
      <div >
        <Sessions source="/users/1/answers"/>
      </div>
    );
  }
});

if (document.getElementById('notebook')) {
  React.render(<NoteBook />,  document.getElementById('notebook'));
}
