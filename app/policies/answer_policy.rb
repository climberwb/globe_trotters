#TODO get application to recognize AnswerPolicy

class AnswerPolicy < ApplicationPolicy

  def show_answer?
     user && user==record
  end


end
