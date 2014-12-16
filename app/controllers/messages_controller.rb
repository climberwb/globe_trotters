class MessagesController < ApplicationController
  def index
    @conversation_id = params[:conversation_id]
  # @messages = Message.where(:conversation_id => @conversation_id) mikis code
    @messages = Message.where(:conversation_id => current_user.team_id)
    @team_chat = current_user.team_id

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
