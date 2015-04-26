class WelcomeController < ApplicationController
  def index
   # instance variables displayed in applcation.html.erb
   # variables are meant to render globe only for welcome#index(root) page
   @controller="welcome" 
   @action="index" 
  end

  def about
  end
end
