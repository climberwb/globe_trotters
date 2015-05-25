class AddIndividualRelationshipToVidconference < ActiveRecord::Migration
  def change
    add_reference :vidconferences, :individual_relationship, index: true
  end
end
