class Users::RegistrationsController < Devise::RegistrationsController
  # def update
  #   if current_user.update_attributes(user_params)
  #     flash[:notice] = "User information updated"
  #     redirect_to edit_user_registration_path(current_user)
  #   else
  #     redirect_to :back
  #     flash[:notice] = current_user.errors.inspect
  #   end
  # end

  #  #if current_user.roles == nil
  # private

  # def user_params
  #   params.require(:user).permit(:name,:avatar, :email_favorites)
  # end
     
end