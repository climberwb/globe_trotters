class ConversationsController < ApplicationController
  def index
    @conversations =  Conversation.where("home_team_id = ? OR visiting_team_id = ? OR team_id = ?", current_user.team.id, current_user.team.id, current_user.team.id) #Conversation.where(:team_id => current_user.team.id)
    @hello = 'hello'
  end
end