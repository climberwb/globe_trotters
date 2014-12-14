class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  
  # This is the captain's team relation
  has_one :my_team, class_name: "Team", foreign_key: "captain_id"
  #for avatar
  mount_uploader :avatar, AvatarUploader
  # This is the teammates realtion
  belongs_to :team

  # chat relationship
  has_many :conversations, :foreign_key => :sender_id
  has_many :messages
  
  # belongs_to :captain, class_name: "User"

  # has_many :teammates, class_name: "User", foreign_key: "captain_id"

  def teammate?
   role == 'teammate'
  end

  def team_captain?
    role == 'team_captain'
  end

  def admin?
    role == 'admin'
  end
end

