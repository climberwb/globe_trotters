class WelcomeController < ApplicationController
  def index
    @team_pic = current_user.avatar.profile.url
    @test='hello'
  end

  def about
  end
end
