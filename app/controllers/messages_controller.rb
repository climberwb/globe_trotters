class MessagesController < ApplicationController
  def index
    @conversation_id = params[:conversation_id]
    @messages = Message.where(:conversation_id => @conversation_id)
  end
  
  def create
    @message = current_user.messages.create!(message_params)
  end

  protected
  def message_params
    params.require(:message).permit(:body)
  end
end
