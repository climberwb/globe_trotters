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

  # chat relationship for user to user
  has_many :conversations, :foreign_key => :sender_id
  has_many :conversations, :foreign_key => :recipient_id

  has_many :messages

  # belongs_to :captain, class_name: "User"

  # has_many :teammates, class_name: "User", foreign_key: "captain_id"
  belongs_to :vidconference

  validate :user_count_within_limit, :on => :update

  has_one :teammate_relationship, foreign_key: "receiver_id"
  has_one :teammate_relationship, foreign_key: "sender_id"

  scope :captains, ->  { find Team.select(:captain_id).map(&:captain_id) }

  def user_count_within_limit
    if vidconference.users.count > 1
      errors.add(:base, "Exceeded thing limit")
    end
  end
## self.current allows to set the current user also relates to code in application controller
   def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

## rolse for user
  def teammate?
   role == 'teammate'
  end

  def team_captain?
    role == 'captain'
  end

  def admin?
    role == 'admin'
  end
end

