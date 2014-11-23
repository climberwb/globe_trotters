class RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      welcome_about_path(resource)
    end
  #   def binary_selection
  #       @user = current_user
  #       # change_role = params[:user][:role]
  #        puts "bloydf"
  #        puts current_user.name
  #        #binding.pry
  #        #binding.pry
  #       # @user.update_attribute(:role, params[:user][:role])
  #       if @user.role != nil
  #          redirect_to root_path
  #       else
  #         #current_user.update_attributes(params[:role])
  #         puts 'hello'
  #         if params[:format] != 13
  #           @user.update_attribute(params[:user][:role])
  #         end

  #       end
  # end
end