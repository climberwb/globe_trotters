class WelcomeController < ApplicationController
  def index
    if current_user && current_user.vidconference
      redirect_to vidconference_path(current_user.vidconference)
    end
   # instance variables displayed in applcation.html.erb
   # variables are meant to render globe only for welcome#index(root) page
   @controller="welcome"
   @action="index"

  end

  def about
  end
end
