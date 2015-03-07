class Captains::TeamsController < ApplicationController
  respond_to :html, :js

  def new
    @team = Team.new
    @captain = current_user
  end
 
  def create
   
    @captain = current_user.id

    @team = Team.create(
              :name => params[:team][:name],
              :location  => params[:team][:location],
              :sport  => params[:team][:sport],
              :captain_id => @captain,
              :avatar => params[:team][:avatar]

            )
     User.find(@captain).update_attributes(:team_id =>@team.id)
    if @team.present?
      redirect_to @team # show view for team 
    end
  end
 def verify_address
    @address = params[:team][:location]
    @validate_address = Team.location_search(@address)
    redirect_to  new_captain_team_path(current_user.id)
  end
  # def address_show
  #   @address = params[:team][:location]
  #   @validate_address = Team.validate_address(@address)
  #   redirect_to  new_captain_team_path(current_user.id)
  # end
  
  def edit
  end

  def update
  end

  def destroy
  end
end
