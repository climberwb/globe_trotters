class Answer < ActiveRecord::Base
belongs_to :user
belongs_to :question

  def self.answer_string(user)
    # sorted_list = user.answers.sort { |a, b|  a.id <=> b.id }
     @answer_string  =   {
                                "currentUser"=> {
                                  "name"=> user.name,
                                  "answers"=>[]
                                                 }
                          }
      pendingCount = 0

      answers = user.answers.order(:id).map do |answer|
           pendingCount=pendingCount+1 if answer.pending == true

           if pendingCount < 2 || answer.pending == false
             {
              "answerContent"=> answer.content ? answer.content : "",
              "questionContent"=> answer.question.content,
              "pendingStatus"=>answer.pending,
              "answerId"=>answer.id,
              "ownerId"=>user.id
              }
            end
       end
       answers.delete_if{|answer| answer==nil}
       @answer_string["currentUser"]["answers"] = answers.sort_by { |row| [row['pendingStatus'] ? 0 : 1] }
       @answer_string
  end
end
