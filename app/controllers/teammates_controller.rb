class TeammatesController < ApplicationController
  def new
   @teammate = current_user
  end

  def create
    @teammate = current_user.update_attribute(
              :bio, params[:teammate][:bio]
            )
    if @teammate.present?
      #team1.teammates << @teammates
      redirect_to teammate_path(current_user)
    end
  end


  def show
    @teammate = User.find(params[:id])
  end

  def add_teammate_to_team
    @team = Team.find(params[:id])
    @team.teammates << current_user
   redirect_to @team
  end
end
private 

def teammate_params
   params.require(:teammate).permit(:avatar)
end