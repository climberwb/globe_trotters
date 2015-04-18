class Notebook < ActiveRecord::Base
  belongs_to :user

  has_many :icebreaker_sessions, dependent: :destroy
  has_many :questions, :through => :icebreaker_sessions
end
