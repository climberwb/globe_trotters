class TeamsController < ApplicationController
  respond_to :html, :js
  
  def new
   @team = Team.new
   @conversation = Conversation.new
  end

  def create
    @team = Team.create(
              :name => params[:team][:name],
              :location => params[:team][:location],
              :sport  => params[:team][:sport],
              :captain_id => current_user.id,
              :bio => params[:team][:bio]
            )
    @conversation = Conversation.create(:team_id => @team.id)
    if @team.present? && @conversation.present?
      redirect_to @team
    end

  end

  # def geo_json
  #   redirect_to @team
  # end

  def index
      @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end
end
