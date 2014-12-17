class UsersController < ApplicationController
  respond_to :json, :html

  def admin_form
    @user = current_user
  end
  def admin_info_create
    @admin = current_user.update_attributes(
              :bio => params[:user][:bio],
              :avatar => params[:user][:avatar]
            )
    #if @admin.present?
      #team1.teammates << @teammates
      redirect_to admin_show_path(current_user)
   # end
  end

  def admin_show
    @admin = User.find(params[:id]) 
  end

   def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path(current_user)
    else
      redirect_to :back
      flash[:notice] = current_user.errors.inspect
    end
  end

  def binary_selection
    @user = User.find(params[:id])
  end
  def binary_selection_update
    @user = User.find(params[:id]) 
    url = @user.id
    if @user.update_attribute(:role, params[:user][:role]) 
      if @user.role == "captain"
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
 

   def create
  end
  def index
  end
 private

  def user_params
    params.require(:user).permit(:name,:avatar)
  end
end
