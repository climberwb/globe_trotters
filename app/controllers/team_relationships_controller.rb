class TeamRelationshipsController < ApplicationController
  def new
  end
  def index
    @team_relationships = TeamRelationship.where(receiver_team: current_user.team)   
  end

  def show

  end

  def create
    #binding.pry
    @team_relationship = TeamRelationship.create!(message_params)
    @team_relationship.save
    render :json => {:status => "Request Sent" }.to_json

  end

  # def index
  # end

  def destroy
  end

  def update
  end
  def team_accept
    @team_relationship = TeamRelationship.where(params[:team_relationships][:sender_team_id]).where(params[:team_relationships][:receiver_team_id]).first
    @team_relationship_accept = @team_relationship.update_attributes(:accepted_at=> Time.new)
    @team_relationship.save
    render :json => {:status => "Accept" }.to_json
   #
  end

  def team_decline
    @team_relationship_accept = TeamRelationship.where(params[:team_relationships][:sender_team_id]).where(params[:team_relationships][:receiver_team_id]).first.update_attributes(:rejected_at=> Time.new)
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:team_relationships).permit(:sender_team_id, :receiver_team_id)
  end
end
