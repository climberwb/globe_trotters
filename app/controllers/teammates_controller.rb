class TeammatesController < ApplicationController
  def new
   @teammate = current_user
  end
  def create
    @teammate = current_user.update_attribute(
              :bio, params[:teammate][:bio]
            )
    if @teammate.present?
      redirect_to teammate_path(current_user)
    end
  end


  def show
    @teammate = User.find(params[:id])
  end
end
