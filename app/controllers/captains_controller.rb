class CaptainsController < ApplicationController
  def index
  end

  def create
  endyou da
  end
  def destroy
  end


  def update
  end

  def new
   #@captain = current_user
  end
  
  def create
    @captain = current_user.update_attribute(
              :bio, params[:captain][:bio]
            )
    if @captain.present?
      #team1.teammates << @teammates
      redirect_to captain_path(current_user)
    end
  end


  def show
    @captain = User.find(params[:id])
    @team = @captain.team
  end

end
