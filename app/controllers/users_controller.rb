class UsersController < ApplicationController

  def binary_selection
    @user = current_user
    #@change_role = params[:user][:role]
     puts "alot1"
     
    @user.update_attribute(:role, "bjhjej")
    redirect_to root_path
  end
  

end
