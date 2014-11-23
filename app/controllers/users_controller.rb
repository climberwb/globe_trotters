class UsersController < ApplicationController
  respond_to :json, :html

  def binary_selection
    @user = User.find(params[:id])
  end
  def binary_selection_update
    @user = User.find(params[:id])  
    if @user.update_attribute(:role, params[:user][:role])
      redirect_to root_path, notice: "#{@user.name} was updated."
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
