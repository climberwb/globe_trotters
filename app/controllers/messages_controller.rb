class MessagesController < ApplicationController


  # def index_multi_team_chat
  #   #@conversation_id = params[:conversation_id]
  #   @conversation = Conversation.where("home_team_id = ? OR visiting_team_id = ?", params[:team_id], params[:team_id])
  # # @messages = Message.where(:conversation_id => @conversation_id) mikis code
  #   @messages = Message.where(:conversation_id => current_user.team.home_team_id)#make this the same as index except not nil
  #   @team_chat =  current_user.team.home_team_id #same as index except where :home_team_id instead of :team_id
  # end

  # def create_multi_team_chat
  #   @message = current_user.messages.create!(message_params)
  # # @team_chat = current_user.team_id
  # end

  def index
    @conversation_id = params[:messages][:conversation_id]
  # @messages = Message.where(:conversation_id => @conversation_id) mikis code
    @messages = Conversation.find(@conversation_id).messages
    #@messages = Conversation.where(:team_id => current_user.team_id).where(:home_team_id => nil).first.messages #Message.where(:conversation_id => current_user.team_id)#Conversation.where(:team_id =>current_user.team_id).first.messages
    #@team_chat = Conversation.where(:team_id => current_user.team_id).first.id
  end

  def create
    @message = current_user.messages.create!(message_params)
  # @team_chat = current_user.team_id
  end



  protected
  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
