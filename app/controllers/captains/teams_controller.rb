class Captains::TeamsController < ApplicationController
  def new
    @team = Team.new
    @captain = current_user
  end

  def create
    @captain = current_user.id
    @team = Team.create(
              :name => params[:team][:name],
              :location  => params[:team][:location],
              :sport  => params[:team][:sport]
            )
    if @team.present?
      redirect_to @team # show view for team 
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
