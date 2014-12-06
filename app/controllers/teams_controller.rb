class TeamsController < ApplicationController
  
  def new
   @team = Team.new
  end
  def create
    @team = Team.create(
              :name => params[:team][:name],
              :location => params[:team][:location],
              :sport  => params[:team][:sport],
              :captain_id => current_user.id,
              :bio => params[:team][:bio]
            )
    if @team.present?
      redirect_to @team
    end
  end

  def index
      @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

end