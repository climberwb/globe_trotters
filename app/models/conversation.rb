class Conversation < ActiveRecord::Base
  #belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  #belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  #this represents just the internal chat
  belongs_to :team

  # group chat relation for team
  belongs_to :home_team, class_name: "Team"
  belongs_to :visiting_team, class_name: "Team"

  #has_one :home_team, class_name: "Team", foreign_key: "home_team_id"
  #messages
  has_many :messages, dependent: :destroy
  #validates_presence_of :messages

  #validates_uniqueness_of :sender_id, :scope => :recipient_id

  # scope :involving, -> (user) do
  #   where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  # end

  # scope :between, -> (sender_id,recipient_id) do
  #   where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  # end

  def title
    if self.team_id.present?
      "Internal chat for the #{self.team.name}"
    else
      "Group chat of #{self.home_team.name}, #{self.visiting_team.name}"
    end
  end
end
