 class UsersController < ApplicationController
  respond_to :json, :html

def admin_show
   @admin = User.find(params[:id])
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

  def admin_form
    @user = current_user
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
         # '/captains/'"#{url}"'/teams/new'
        redirect_to new_captain_team_path(current_user.id), notice: "#{@user.id} was updated."
        elsif @user.role == "teammate"
          redirect_to new_teammate_path
        elsif @user.role == "individual"
          redirect_to individual_form_path
        end
    end
   end

  def individual_form
    @user = current_user
  end

  def individual_form_post
    #TODO: update user for individual account add pundit
    puts 'dfasfadf'
     @user = current_user.update_attributes(user_params)
     if current_user.save
        redirect_to individual_show_path(current_user)
     end

  end

  def individual_show
    @user = User.find(params[:id])
    @current_relationship = IndividualRelationship.where(sender_id: current_user.id).first
  end
  def to_geo_json
   render :json => User.to_geojson.to_json
  end

   def location_search
    p params
    location = params[:location]

    render :json => User.location_search(location).to_json
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
    params.require(:user).permit(:name,:avatar,:bio,:location)
  end
end
