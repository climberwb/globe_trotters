class AnswersController < ApplicationController
  def edit
  end

  def update
  end

  def show
    #@answers = current_user.answers
  end

  def index
    if current_user && current_user.answers
      render :json => Answer.answer_string(current_user).to_json
    end
  end

  def new
  end

  def create
        render :json => User.location_search(location).to_json

  end

  def destroy
  end

end
