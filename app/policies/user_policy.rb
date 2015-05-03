class UserPolicy < ApplicationPolicy

  attr_reader :user, :form_user

  def initialize(user, form_user)
    @user = user
    @form_user = form_user
  end

  def individual_form?
    user && user == form_user
  end
  def individual_form_post?
    individual_form?
  end

  def individual_show?
   individual_form? || (user && user.traveler? && form_user.host?) || (user && user.host? && form_user.traveler?)
  end

end