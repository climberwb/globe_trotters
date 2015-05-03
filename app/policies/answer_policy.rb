class AnswerPolicy < ApplicationPolicy

  def show_answer?
    binding.pry
     user && user==record
  end


end
