class RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      welcome_about_path(resource)
    end
    #  def after_sign_in_path_for(resource)
    #     if User.where(email: params[:user][:email]).first.role == nil ## temporary solution
    #       binary_selection_path(resource)
    #     end
    # end
    # def after_inactive_sign_up_path_for(resource)
    #   welcome_about_path
    # end
end