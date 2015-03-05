class TeamRelationshipsController < ApplicationController
  def new
  end

  def show

  end

  def create
    @team_relationship = TeamRelationship.create!(message_params)
    render :json => {:status => "Request Sent" }.to_json

  end

  # def index
  # end

  def destroy
  end

  def update
  end

  protected
  def message_params
    params.require(:team_relationships).permit(:sender_team_id, :receiver_team_id)
  end
end
