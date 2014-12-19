class Team < ActiveRecord::Base
   # belongs_to :captain, class_name: "User"
  belongs_to :captain, class_name: "User"
  has_many :teammates, class_name: "User"

  has_one :conversation
  validates_presence_of :conversation

  mount_uploader :avatar, AvatarUploader
  # team has one team that would like to stay in contact with
  has_one :visitor_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :home_team, class_name: "Team"



  # making home_team the multiple team chat relation
 # belongs_to :group_conversation, class_name: "Conversation"

end