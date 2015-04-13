class Question < ActiveRecord::Base
  has_many :icebreaker_sessions, dependent: :destroy
  has_many :notebooks, :through => :icebreaker_sessions
end
