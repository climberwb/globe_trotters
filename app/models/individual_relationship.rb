class IndividualRelationship < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validate :individual_relations_count_within_limit, :on => :create
  def individual_relations_count_within_limit
    if IndividualRelationship.where(sender: sender).first
      errors.add(:base, "Exceeded request limit")
    end
  end
end