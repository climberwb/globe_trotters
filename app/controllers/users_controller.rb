class UsersController < ApplicationController

  def binary_selection
    @user = current_user
    # change_role = params[:user][:role]
     puts "bloydf"
     puts current_user.name
     @user.update_attribute(:role, params[:role])
    if @user.role != nil
       redirect_to root_path
    end
  end

  def new
  end
  def show
  end
  def create
  end
  def update
  end


end
