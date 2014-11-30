class Teams::TeammatesController < ApplicationController
  def index
  end

  def new
    @team = Team.new
  end

  def create
    Team = Team.create(
              :name => params[:team][:name],
              :location  => params[:team][:location],
              :sport  => params[:team][:sport]
            )
    if Team.present?
      redirect_to captain_team_path
    end
  end

  def destroy
  end

  def show
  end
end
