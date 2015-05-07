require 'sendgrid-ruby'

class IndividualRelationship < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"


  validate :individual_relations_count_within_limit, :on => :create
  def individual_relations_count_within_limit
    if IndividualRelationship.where(sender: sender).first
      errors.add(:base, "Exceeded request limit")
    end
  end

  def self.mail(sender)
    client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'], api_key: ENV['SENDGRID_PASSWORD'])
    client.send(SendGrid::Mail.new(to: sender.email, from: 'BeGoodGlobal', subject: 'You have a friend!', html: '<a href="hello.com">Hi there!</a>'))
  end
end