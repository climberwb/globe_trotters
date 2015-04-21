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
      pendingCount = 0
      answers = user.answers.map do |answer|
           pendingCount=pendingCount+1 if answer.pending == true
           if pendingCount < 2
             {
              "answerContent"=> answer.content ? answer.content : "",
              "questionContent"=> answer.question.content,
              "pendingStatus"=>answer.pending
              }
            end
       end
       answers.delete_if{|answer| answer==nil}
       @answer_string["currentUser"]["answers"] = answers
       @answer_string
  end
end
