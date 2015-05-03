class UserPolicy < ApplicationPolicy

  

  def individual_form?
    user && user == record
  end

  def individual_form_post?
    individual_form?
  end

  def individual_show?
   individual_form? || (user && user.traveler? && record.host?) || (user && user.host? && record.traveler?)
  end

end