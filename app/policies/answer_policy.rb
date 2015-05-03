#TODO get application to recognize AnswerPolicy

class AnswerPolicy < ApplicationPolicy

  def show_answer?
    binding.pry
     user && user==record
  end


end
