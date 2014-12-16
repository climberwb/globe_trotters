class Team < ActiveRecord::Base
   # belongs_to :captain, class_name: "User"
  belongs_to :captain, class_name: "User"
  has_many :teammates, class_name: "User"

  has_one :conversation
  mount_uploader :avatar, AvatarUploader 

  has_one :visitor_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :home_team, class_name: "Team"
  
end