class AnswersController < ApplicationController
  def edit
  end

  def update
    #TODO go back to update
    @answer=Answer.find(params[:id])
    content=params[:answer][:content]
    @answer.update_attributes(:content=> content)
    Answer.grant_friendship_access(current_user)
    render :json => { "answerContent"=> @answer.content}.to_json
  end

  def show
  end

  def index
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
    render :json => { "updateStatus"=> true}.to_json
  end

  def destroy
    @answer=Answer.find(params[:id])
    @answer.update_attributes(:content=>"",:pending=>true)
  end

end
