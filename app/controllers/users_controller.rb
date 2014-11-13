class UsersController < ApplicationController

  def binary_selection
    @user = current_user
    # change_role = params[:user][:role]
     puts "alot1"
     
    if !@user.update_attribute(:role, "hello")
       redirect_to root_path
    end
  end
  

end
