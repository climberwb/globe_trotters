class Users::RegistrationsController < Devise::RegistrationsController
  protected

   #if current_user.roles == nil
     def after_sign_in_path_for(resource)
      welcome_about_path
     end
  # end
end