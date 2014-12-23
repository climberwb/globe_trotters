class Team < ActiveRecord::Base
   # belongs_to :captain, class_name: "User"
  belongs_to :captain, class_name: "User"
  has_many :teammates, class_name: "User"

  #this represents just the internal chat
  has_one :conversation

  # team has one team that would like to stay in contact with
  # has_one :visiting_team, class_name: "Team", foreign_key: "visiting_team_id"
  # has_one :home_team, class_name: "Team", foreign_key: "home_team_id"

  # validates_presence_of :conversation



  mount_uploader :avatar, AvatarUploader

  # making home_team the multiple team chat relation
 # belongs_to :group_conversation, class_name: "Conversation"

end