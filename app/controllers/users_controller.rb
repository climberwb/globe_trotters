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

 redirect_to admin_show_path(current_user)
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

      @questions = Question.all.shuffle
      if current_user.answers ==nil
        @questions.each_with_index do |question,index|
          new_answer = Answer.create(:question_id=>question.id,:user_id=>current_user.id)
          break if index == 3
        end
      end
     if current_user.save

     @user = current_user.update_attributes(user_params)
         redirect_to "#{user_answers_path(current_user)}/show"
        #redirect_to individual_show_path(current_user)
     end

  end

  def individual_show
    @user = User.find(params[:id])
    if current_user
      @current_relationship = IndividualRelationship.where(sender_id: current_user.id).first
    end
      @new_relationship = IndividualRelationship.new
  end
  def to_geo_json
    individual_hash = User.to_geojson
    # you can loop through users with this  individual_hash["features"][1]["properties"][0]
    # where first array is coords and second is users within coords
    individual_hash["features"].each do |properties|
      if current_user && current_user.travel_status == "host"
        properties["properties"].delete_if { |user| user["TravelStatus"] == "host" }
      elsif current_user && current_user.travel_status == "traveler"
        properties["properties"].delete_if { |user| user["TravelStatus"] == "traveler" }
      end
    end
     individual_hash["features"].delete_if{|feature| feature["properties"].length ==0}
     render :json =>individual_hash.to_json
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
