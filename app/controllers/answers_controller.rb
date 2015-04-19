class AnswersController < ApplicationController
  def edit
      new_answer = Answer.new
      current_user << new_answer
  end

  def update
  end

  def show
  end

  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

end
