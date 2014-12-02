class UsersController < ApplicationController
  respond_to :json, :html

  def binary_selection
    @user = User.find(params[:id])
  end
  def binary_selection_update
    @user = User.find(params[:id]) 
    url = @user.id
    if @user.update_attribute(:role, params[:user][:role]) 
      if @user.role == "captain"
       # '/captains/'"#{url}"'/teams/new'
      redirect_to new_captain_team_path(current_user.id), notice: "#{@user.id} was updated."
      elsif @user.role == "teammate"
        redirect_to new_teammate_path
      end
    else
     # format.html { render action: "edit" }
    end
  end

  def new
  end
  def show
  end
 
  def update

  end
   def create
  end
  def index
  end
end
