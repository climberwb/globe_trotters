class AnswersController < ApplicationController
  def edit
  end

  def update
    #TODO go back to update
    @answer=Answer.find(params[:id])
    content=params[:answer][:content]
    @answer.update_attributes(:content=> content)
    render :json => { "answerContent"=> @answer.content}.to_json
  end

  def show
    #binding.pry
    @user = User.find(params[:user_id])
    # TODO Commented code does not work make pundit recognize application_policy and delete hack
    #authorize @user,:show_answer?
    redirect_to root_path if current_user.friendship_eligible == true || @user != current_user
  end

  def index
    # TODO Commented code does not work make pundit recognize application_policy and delete hack
    #authorize @user,:index?

    redirect_to root_path if current_user.friendship_eligible == true 

    if current_user && current_user.answers
      render :json => Answer.answer_string(current_user).to_json
    end
  end

  def new
  end

  def create
    @answer=Answer.find(params[:answer][:id])
    content=params[:answer][:content]
    @answer.update_attributes(:content=> content,:pending=>false)
    Answer.grant_friendship_access(current_user)
    render :json => { "updateStatus"=> true}.to_json
  
  end

  def destroy
    @answer=Answer.find(params[:id])
    @answer.update_attributes(:content=>"",:pending=>true)
  end

end
