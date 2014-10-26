class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # This is the captain's team relation
  has_one :owned_team, class_name: "Team"

  # This is the teammates realtion
  belongs_to :team

  belongs_to :captain, class_name: "User"
  
  has_many :teammates, class_name: "User"
end
