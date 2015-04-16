class IndividualRelationshipPolicy < ApplicationPolicy
#TODO go back to Using the Policy Rules to Restrict Controller Actions in bloc tutorial


   def index?
     scope.where(id: record.id).exists?
     #binding.pry

   end
   def show?
    user.present?#index?
   end
   def accept?
   end
   def decline?
   end
   def delete?
   end
   def create?
   end
end