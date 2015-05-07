class Answer < ActiveRecord::Base
belongs_to :user
belongs_to :question

  def self.answer_string(user)
    # sorted_list = user.answers.sort { |a, b|  a.id <=> b.id }
     @answer_string = {
                        "currentUser"=> {
                          "name"=> user.name,
                          "answers"=>[]
                                        }
                      } 
      pendingCount = 0 #initialize the count of pending object 

      answers = user.answers.order(:id).map.with_index do |answer,index|
           pendingCount=pendingCount+1 if answer.pending == true

           if pendingCount < 2 || answer.pending == false
             {
              "answerContent"=> answer.content ? answer.content : "",
              "questionContent"=> answer.question.content,
              "videoUrl"=>answer.question.video_url,
              "pendingStatus"=>answer.pending,
              "answerId"=>answer.id,
              "ownerId"=>user.id,
              "lastAnswer"=> user.answers.length-1 == index ? true : false
              }
            end
       end
       answers.delete_if{|answer| answer==nil}
       @answer_string["currentUser"]["answers"] = answers.sort_by { |row| [row['pendingStatus'] ? 1 : 0] }
       @answer_string
  end

  def self.grant_friendship_access(user)
    false_answer_count=0
    user.answers.each do |answer|
      false_answer_count=false_answer_count+1 if answer.pending==false
    end
    user.update_attributes(:friendship_eligible=>true) if user.answers.length == false_answer_count 
    user.answers.length == false_answer_count 
  end 

end
