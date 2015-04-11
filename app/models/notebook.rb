class Notebook < ActiveRecord::Base
  belongs_to :individual_relationship

  has_many :icebreaker_sessions
  has_many :questions, :through => :icebreaker_sessions
end
