class ConversationsController < ApplicationController

  def new
    @home_team = current_user.team.id
    @teams = Team.all
    @conversation = Conversation.new
  end
  def create
    @conversation = Conversation.create!(message_params)
    if @conversation.present?
      redirect_to conversations_path
    end
  end
  def index
    @conversations =  Conversation.where("home_team_id = ? OR visiting_team_id = ? OR team_id = ?", current_user.team.id, current_user.team.id, current_user.team.id) #Conversation.where(:team_id => current_user.team.id)
    @hello = 'hello'
  end

  protected
  def message_params
    params.require(:conversation).permit(:home_team_id, :visiting_team_id)
  end
end