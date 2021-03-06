class IndividualRelationshipPolicy < ApplicationPolicy
#TODO go back to Using the Policy Rules to Restrict Controller Actions in bloc tutorial


   def index?
     scope.where(id: record.id).exists? && user.friendship_eligible?
   end
   
   def show?
    user.present? && user.friendship_eligible?
   end
   
   def accept?
    user.friendship_eligible?
   end
   
   def decline?
    user.friendship_eligible?
   end
   
   def delete?
    user.friendship_eligible?
   end
   
   def create?
      relationship = IndividualRelationship.where(sender: user).first
      user.present? && relationship == nil && user.friendship_eligible? && user.traveler?  
   end
end