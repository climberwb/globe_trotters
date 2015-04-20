class Answer < ActiveRecord::Base
belongs_to :user
belongs_to :question

  def self.answer_string(user)
     @answer_string  =   {
                                "currentUser"=> {
                                  "name"=> user.name,
                                  "answers"=>[]
                                }
                            }
      answers = user.answers.map do |answer|
             {
              "answerContent"=> answer.content,
              "questionContent"=> answer.question.content
              }
       end
       @answer_string["currentUser"]["answers"] = answers
       @answer_string
  end
end
