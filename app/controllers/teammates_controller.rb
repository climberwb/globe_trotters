class TeammatesController < ApplicationController
  def new
   @teammate = current_user
  end

  def create
    @teammate = current_user.update_attributes(
              :bio => params[:teammate][:bio],
              :avatar => params[:teammate][:avatar]
            )
    if @teammate.present?
      #team1.teammates << @teammates
      redirect_to teammate_path(current_user)
    end
  end


  def show
    @teammate = User.find(params[:id])
  end

  def add_teammate_to_team
    @team = Team.find(params[:id])
    @team.teammates << current_user
    @team.teammates.each do |teammate|
      if teammate.id != current_user.id
         @new_convo =  Conversation.new
         @create_convo = Conversation.create!(
              :team_id => current_user.team.id,
              :sender_id => current_user.id,
              :recipient_id => teammate.id
            )
         @new_convo
         @create_convo
      end
        if @conversation.present?
         # put something to verify a conversation was made or not
        end
    end
   redirect_to @team
  end

private

def teammate_params
   params.require(:teammate).permit(:avatar)
end
def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end
end