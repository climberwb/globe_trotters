class TeamRelationship < ActiveRecord::Base


  belongs_to :sender_team, class_name: "Team"
  belongs_to :receiver_team, class_name: "Team"
  has_many :teammate_relationships

  #only one friend request can be sent at a time per team
  validate :team_relations_count_within_limit, :on => :create
  def team_relations_count_within_limit
    if TeamRelationship.where(sender_team: sender_team).first
      errors.add(:base, "Exceeded request limit")
    end
    # if TeamRelationship.where("sender_team_id = ?", User.current.team.id).count > 2
    #   errors.add(:base, "Exceeded request limit")
    # end
  end
end
