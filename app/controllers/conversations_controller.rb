class ConversationsController < ApplicationController

  def new
    @home_team = current_user.team.id
    @teams = Team.all
    @conversation = Conversation.new
  end

  def create
    #creates conversation between two teams
    @conversation = Conversation.create!(message_params)
   ###########################
    # creates conversation between all teammates of two teams hold off for now
    @home_team = @conversation.home_team
    @visiting_team = @conversation.visiting_team

    @visiting_team.teammates.each do |visiting_teammate|
      @home_team.teammates.each do |home_teammate|
           @user_team_to_team =  Conversation.new
           @user_team_to_team
           @user_team_to_team = Conversation.create!(
                :home_team_id => @conversation.home_team.id,
                :visiting_team_id => @conversation.visiting_team.id,
                :sender_id => visiting_teammate.id,
                :recipient_id => home_teammate.id
              )
           @user_team_to_team
              if @conversation.present?
               # put something to verify a conversation was made or not
              end
        end
    end

    if @conversation.present?
      redirect_to conversations_path
    end
  end
  def index


   @user_conversations = Conversation.where("team_id = ?", current_user.team.id).where("sender_id = ? OR recipient_id= ?", current_user.id, current_user.id)
    @conversations =  Conversation.where("home_team_id = ? OR visiting_team_id = ? OR team_id = ? ", current_user.team.id, current_user.team.id, current_user.team.id).where(:sender_id => nil).where(:recipient_id => nil)
      if current_user.team ==  Conversation.where("home_team_id = ? OR visiting_team_id = ? ", current_user.team.id, current_user.team.id).first.home_team
            @opposing_team = Conversation.where("home_team_id = ? OR visiting_team_id = ? ", current_user.team.id, current_user.team.id).first.visiting_team
      else
            @opposing_team = Conversation.where("home_team_id = ? OR visiting_team_id = ? ", current_user.team.id, current_user.team.id).first.home_team
      end
            @opposing_team_conversations = Conversation.where("home_team_id = ? OR visiting_team_id = ? ", current_user.team.id, current_user.team.id)
  end

  protected
  def message_params
    params.require(:conversation).permit(:home_team_id, :visiting_team_id)
  end
  ###############################
  #code for individuals to chat within team to team chat hold off for now
  def home_team_param
    params[:conversation][:home_team_id]
  end
  def visting_team_param
    params[:conversation][:visiting_team_id]
  end
end