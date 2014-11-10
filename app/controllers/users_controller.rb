class UsersController < ApplicationController

  def binary_selection
    @user = User.find(current_user.id)
    puts current_user.id
    puts "efefefe"
  end
  

end
