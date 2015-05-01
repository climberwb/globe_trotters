class TeamRelationshipsController < ApplicationController
  def new
  end
  def index
    @team_relationships = TeamRelationship.where(receiver_team: current_user.team)   
  end

  def show

  end

  def create
    #
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
    sender_id = params[:team_relationships][:sender_team_id].to_i
    receiver_id = params[:team_relationships][:receiver_team_id].to_i
    sender_team_name = Team.find(sender_id).name
    # @team_relationship = TeamRelationship.where(params[:team_relationships][:sender_team_id]).where(params[:team_relationships][:receiver_team_id]).first

    @team_relationship = TeamRelationship.where(sender_team_id: sender_id, receiver_team_id: receiver_id).first
    @team_relationship_accept = @team_relationship.update_attributes(:accepted_at=> Time.new)
    @team_relationship.save!
    render :json => {:status => "Accept",:team =>{:link =>"teams/#{sender_id}", :name => sender_team_name} }.to_json
   #
  end

  def team_decline
    sender_id = params[:team_relationships][:sender_team_id].to_i
    receiver_id = params[:team_relationships][:receiver_team_id].to_i

    @team_relationship = TeamRelationship.where(sender_team_id: sender_id, receiver_team_id: receiver_id).first
    @team_relationship_accept = @team_relationship.update_attributes(:rejected_at=> Time.new)
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:team_relationships).permit(:sender_team_id, :receiver_team_id)
  end
end
