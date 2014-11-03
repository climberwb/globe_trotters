class RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      welcome_about_path(resource)
    end
    
    def after_inactive_sign_up_path_for(resource)
      welcome_about_path
    end
end