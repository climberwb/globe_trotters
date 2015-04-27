class IndividualRelationshipPolicy < ApplicationPolicy
#TODO go back to Using the Policy Rules to Restrict Controller Actions in bloc tutorial


   def index?
     scope.where(id: record.id).exists? && user.friendship_eligible?
   end
   def show?
    user.present?
   end
   def accept?
   end
   def decline?
   end
   def delete?
   end
   def create?
      relationship = IndividualRelationship.where(sender: user).first
      user.present? && relationship == nil && user.friendship_eligible?
   end
end