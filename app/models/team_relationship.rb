class TeamRelationship < ActiveRecord::Base
  belongs_to :sender_team, class_name: "Team"
  belongs_to :receiver_team, class_name: "Team"
  has_many :teammate_relationships
end
